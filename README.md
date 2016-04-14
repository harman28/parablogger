## Parablogger

 - You'll need Bundler and Postgres installed. Make sure your postgres user has the right permissions to setup DB.
 - Run `INSTALL.sh`

Here's a list of the usable APIs in this repo. Slightly more detailed documentation can be found in the `doc/` folder.

###Create Post

**Short Description** Creates a new post  
**HTTP Verb** POST  
**Route** `/posts/`  
**Request Format**  
````JSON
    {
      "title": "First Post Ever",
      "body": "This is the first post ever.\n\nIt's a great post because it has multiple paragraphs.\n\nMost of them are separated by 2 newlines.\nBut some are not.\n\n\nSome are separated by more.\n\nBas.\n"
    }
````
**Response Format**  
````JSON
	{
		"status": "OK",
		"message": "success",
		"result": {
			"id": 1,
			"title": "First Post Ever",
			"paras": [{
				"id": 1,
				"body": "This is the first post ever."
			}, {
				"id": 2,
				"body": "It's a great post because it has multiple paragraphs."
			}, {
				"id": 3,
				"body": "Most of them are separated by 2 newlines.\nBut some are not."
			}, {
				"id": 4,
				"body": "Some are separated by more."
			}, {
				"id": 5,
				"body": "Bas.\n"
			}],
			"comments": []
		}
	}
````

###Posts Index

**Short Description** Returns compact posts in paginated form  
**HTTP Verb** GET  
**Route** `/posts`  
**Request Format** `/posts?page=1&limit=2`  
**Response Format**  
````JSON
	{
		"status": "OK",
		"message": "success",
		"result": [{
			"id": 1,
			"title": "First Post Ever"
		}, {
			"id": 2,
			"title": "Second Post"
		}]
	}	
````

###Post Show

**Short Description** Returns post info with comments  
**HTTP Verb** GET  
**Route** `/posts/:id`  
**Response Format**  
````JSON
	{
		"status": "OK",
		"message": "success",
		"result": {
			"id": 1,
			"title": "First Post Ever",
			"paras": [{
				"id": 1,
				"body": "This is the first post ever."
			}, {
				"id": 2,
				"body": "It's a great post because it has multiple paragraphs."
			}, {
				"id": 3,
				"body": "Most of them are separated by 2 newlines.\nBut some are not."
			}, {
				"id": 4,
				"body": "Some are separated by more."
			}, {
				"id": 5,
				"body": "Enough of this.\n"
			}],
			"comments": [{
				"id": 2,
				"body": "That makes no sense at all",
				"para_id": 2
			}]
		}
	}	
````

###Post Comment

**Short Description** Returns post info with comments  
**HTTP Verb** POST  
**Route** `/comments/`  
**Request Format**
````JSON
	{
	  "paragraph_id": 2,
	  "body": "That makes no sense at all"
	}
````
**Response Format**  
````JSON
	{
		"status": "OK",
		"message": "success",
		"result": {
			"id": 1,
			"title": "First Post Ever",
			"paras": [{
				"id": 1,
				"body": "This is the first post ever."
			}, {
				"id": 2,
				"body": "It's a great post because it has multiple paragraphs."
			}, {
				"id": 3,
				"body": "Most of them are separated by 2 newlines.\nBut some are not."
			}, {
				"id": 4,
				"body": "Some are separated by more."
			}, {
				"id": 5,
				"body": "Enough of this.\n"
			}],
			"comments": [{
				"id": 2,
				"body": "That makes no sense at all",
				"para_id": 2
			}]
		}
	}	
````
