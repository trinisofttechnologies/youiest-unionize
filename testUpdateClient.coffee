# rule: no updates in W, only inserts. Unless it's a hook or cronjob, and we meaure it's speed

#global variable not in here? what?
at = "eval(t());eval( 'arguments.callee.caller.toString().match(/(unionize.{20}.*?)/)'[0]);"
l eval(at), 'hi from updateClient.coffee'
  
    

Meteor.methods
  "dummyInsert" : (insert) ->
    Meteor.call 'clearDb'
    e = W.insert
    _id: 'elias'
    n = W.insert
      _id: 'nicolson'
    p = W.insert
      _id: 'picture'
    WI.insert 
      _id: 'elias'
    WI.insert
      _id: 'nicolson'
    l eval(at), 'dummyInsert done and waitingForIt'
  "clearDb": () ->
    W.remove {}
    WI.remove {}
    


Meteor.call 'dummyInsert'

# test that inserting w.to myUserId triggers a hook that inserts it into my.incoming in WI

# test that updating WI on client fires hook and inserts same object into w on server

Collection = if typeof Mongo != 'undefined' and typeof Mongo.Collection != 'undefined' then Mongo.Collection else Meteor.Collection


if Meteor.isClient
  if consoling 
    ConsoleMe.subscribe()
  l  eval(at), 'calling dummyInsert'
  
  Tinytest.addAsync 'update - clientside update of WI should trigger insert into W', (test, next) ->
    Meteor.startup ->
      # performance obsessed logging
      l eval(at),  'startup dummyInsert'

      Meteor.call 'dummyInsert'
      recommendation =
        to: 'elias'
        from: 'picture'
      
      l eval(at)
      , recommendation, recommendation.from 
      ,'testing recommendation'

      # calling connect on the client to do update our WI, later synced when online
      , connect(recommendation) 
      
      #l eval(at), recommendation2, recommendation2.from 
      #, 'testing recommendation2', connect(recommendation2) 
      l eval(at), recommendation.from, WI.findOne({}).outbox , 'outbox'

      # since the sync hasn't gone to server and back (hooks!) we test once the data is here
      picd = Tracker.autorun (computation) ->
        l eval(at), 'checking if ready for test pictured' , W.findOne({to:'elias'})
        # only run the test if we have a candidate
        unless !W.findOne({to:'elias'})
          l eval(at), 'we have a hit' , W.findOne {to:'elias'} .from

          # this appears to fire multiple times. 41 ms untill first pass of sync back and fourth seems good
          test.equal recommendation.from , W.findOne {to:'elias'}.from
          Meteor.call 'clearDb'
        next()

        
        
    # there will only be to:elias if hooks have finishes, add test then
      
      

        return
      return
    return



# test that grounddb syncs back offline changes

# test that grounddb changes synced back to server trigger hooks

# test that hooks follow rules and only maintain enough data on WI objects to load fresh data

# test that I have a sane WI waiting for me when I log in