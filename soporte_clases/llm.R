install.packages('gemini.R')
#https://cran.r-project.org/web/packages/gemini.R/gemini.R.pdf

library(gemini.R)
setAPI("AIzaSyCBNIN7OwKFR47S-tWqzlR4r0ihSt8RfDQ")
chats <- gemini_chat("Imagina que eres un muñeco de nieve y no te salgas del personaje en ningún momento",
                     model='1.5-flash')
print(chats$outputs)
chats <- gemini_chat("Cual es tu estación del año preferida?", chats$history)
print(chats$outputs)
chats <- gemini_chat("How do you think about summer?", chats$history)
print(chats$outputs)



gemini_image(image = '/Users/josemiguelavendanoinfante/Desktop/fotos_varias/coheteariane.jpeg',
             prompt = "En 20 palabras explica lo que ves en la imágen")

#############
# install.packages('gkgraphR')
library(gkgraphR)


gapi_key <- "AIzaSyDkFn438MHXjiOKobGGwLHXXmwOhNakmTk"

query_apple_es <- querygkg(query = "manzana", 
                           lang = "es", 
                           api.key = gapi_key) # Replace YOUR_API_KEY with a valid Google API key

str(query_apple_es)
class(query_apple_es)
View(query_apple_es)

# Query the API for the entities related to the term "apple" representing a "thing"
query_apple_thing <- querygkg(query = "manzana", 
                              type = "Thing", 
                              api.key = gapi_key) #

# The default number of results returned by the API call is 20 to limit the possibility of the request timing out due to too many hits. However, the default limit can also be altered.
# Increasing API limit call to 50
query_apple_limit <- querygkg(query = "apple",
                              limit = 50, 
                              api.key = gapi_key) # Replace YOUR_API_KEY with a valid Google API key


### crear consultas tipo vision y extraer datos
