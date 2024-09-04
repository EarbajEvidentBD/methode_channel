import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL


// Function to fetch data from an API
fun fetchApiData(callback: (String) -> Unit) {
    CoroutineScope(Dispatchers.IO).launch {
        var connection: HttpURLConnection? = null
        try {
            val url = URL("https://jsonplaceholder.typicode.com/posts")  // Example API for list of posts
            connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            connection.connectTimeout = 10000
            connection.readTimeout = 10000

            val responseCode = connection.responseCode
            if (responseCode == HttpURLConnection.HTTP_OK) {
                val response = connection.inputStream.bufferedReader().use { it.readText() }

                // Optionally process response and convert to desired format
                // For example, you can parse the response JSON here if needed

                withContext(Dispatchers.Main) {
                    callback(response)
                }
            } else {
                withContext(Dispatchers.Main) {
                    callback("Error: HTTP $responseCode")
                }
            }
        } catch (e: Exception) {
            withContext(Dispatchers.Main) {
                callback("Error: ${e.message}")
            }
        } finally {
            connection?.disconnect()
        }
    }
}
