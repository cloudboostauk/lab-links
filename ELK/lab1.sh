#Task 2 Step 18 

GET _cat/indices/olympic-events?v 

#Task 2 Step 19
GET _cat/indices/olympic-events?v&h=health,status,index,docs.count,store.size


#Task 3 Step 1
GET _cluster/allocation/explain

#Task 3 Step 2
PUT olympic-events/_settings 
{
   "number_of_replicas": 0
}

#Task 3 Step 3 

GET _cat/indices/olympic-events?v 

#Task 4 Step 1 
POST -reindex 
{
    “source": {
      "index": "olympic-events"
    },          
    "dest": {
        "index": "olympic-events-backup"
    }
}

#Task 4 Step 1 

GET _cat/indices/olympic-events?v 