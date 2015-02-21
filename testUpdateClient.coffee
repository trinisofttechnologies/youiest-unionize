
@clearClientGroundDbs = ->
  WI.remove
    _id: 'elias'
  WI.remove
    _id: 'nicolson'
  -> WI.find({}).count()

Meteor.methods
  "dummyInsert" : (insert) ->
    Meteor.call 'clearDb', (res,err) ->
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
      #smite eval(s), 'dummyInsert called clear and done'
      return clearClientGroundDbs
  "clearDb": () ->
    smite eval(s), 'clearDb'
    W.remove {}
    WI.remove {}

ConsoleMe.enabled = true




#if WI.find({inbox:  { $exists : true } }, {_id: 1}).limit(1) #apparently faster by many times
@recFrom = 'picture'
@recommendation =
  to: 'elias'
  from: recFrom

Meteor.startup ->
  if Meteor.isClient
    test1()
    test2()
    test3()
    #window.location.reload()


Meteor.startup ->
  if Meteor.isClient
    Meteor.call 'dummyInsert', (res,err) ->
      smite eval(s), 'returned'
      Tinytest.addAsync 'update - 0 sequential connect first clientside update of WI should trigger insert into W', (test, next) ->
        smite 'added', eval s
        connect(recommendation)
        smite eval(s), 'connected afer test callback'
        picd = Tracker.autorun (computation) ->
          smite eval(s), 'ran tracker'
          unless !W.findOne({to:'elias'})
            smite eval(s), 'got hit'
            test.equal W.findOne({to:'elias'}).from , recFrom
            next()
  

test1 = ->
if Meteor.isClient
#Meteor.startup -> if Meteor.isClient
#test1 = ->
  smite eval(s), 'starting test 1'
  pre = WI.find({}).count()
  cl = clearClientGroundDbs()
  smite 'did we flush the groundlings out?', pre, cl(), 'if pre > 0 cl yes', eval s
  Meteor.call 'dummyInsert', (req,res) ->
    smite eval(s), 'returned'
    Tinytest.addAsync 'update - clientside update of WI should trigger insert into W', (test, next) ->
      smite eval(s), 'added'
      # update outbox serverside with minimal information.  
      connect(recommendation)
      smite eval(s), 'connected'
      #when client update synced to server, hook inserts w and w is synced to client tracker reruns
      picd = Tracker.autorun (computation) ->
        smite eval(s), 'ran tracker'
        # since the sync hasn't gone to server and back (hooks!) we test once the data is here
        unless !W.findOne({to:'elias'})
          smite eval(s), 'got hit'
          test.equal W.findOne({to:'elias'}).from , recFrom
          next()
          #computation.stop() # APPEARS not necessary

#Meteor.startup -> if Meteor.isClient
test2 = -> 'why not start on start'
if Meteor.isClient
  smite eval(s), 'starting test 2'
  pre = WI.find({}).count()
  cl = clearClientGroundDbs()
  smite 'did we flush the groundlings out?', pre, cl(), 'if pre > 0 cl yes', eval s
  Meteor.call 'dummyInsert', (req,res) ->
    smite eval(s), 'returned from dummyinsert'
    Tinytest.addAsync 'update -  trying again for awake server clientside update of WI should trigger insert into W', (test, next) ->
      smite eval(s), 'added'
      # update outbox serverside with minimal information.  
      connect(recommendation)
      smite eval(s), 'connected'
      #when client update synced to server, hook inserts w and w is synced to client tracker reruns
      picd = Tracker.autorun (computation) ->
        smite eval(s), 'ran tracker'
        # since the sync hasn't gone to server and back (hooks!) we test once the data is here
        unless !W.findOne({to:'elias'})
          smite eval(s), 'got hit'
          test.equal W.findOne({to:'elias'}).from , recFrom
          next()
          #computation.stop() # APPEARS not necessary


#if Meteor.isClient
test3 = ->
if Meteor.isClient
  smite eval(s), 'starting number 3'
  pre = WI.find({}).count()
  cl = clearClientGroundDbs()
  smite 'did we flush the groundlings out?', pre, cl(), 'if pre > 0 cl yes', eval s
  Meteor.call 'dummyInsert', (res,err) ->
    smite eval(s), 'returned from dummyinsert'
    Tinytest.addAsync 'update -  recommend leads to w leads to inbox', (test, next) ->
      smite eval(s), 'added'
      # update outbox serverside with minimal information.  
      connect(recommendation)
      smite eval(s), 'connected'
      #when client update synced to server, hook inserts w and w is synced to client tracker reruns
      inbox = Tracker.autorun (computation) ->
        #TODO this test returns multiple times
        # this doesn't affect the test but looks bad
        inboxed = WI.findOne({inbox:{ $exists: true}})
        smite eval(s), 'ran tracker inbox', inboxed
        # since the sync hasn't gone to server and back (hooks!) we test once the data is here
        unless !inboxed
          smite eval(s), 'got hit'
          smite WI.findOne({inbox:{ $exists: true }}).inbox , eval s
          test.equal WI.findOne({inbox:{ $exists: true }}).inbox[0].from , recFrom
          this.stop()
          next()
           # APPEARS not necessary


###
if Meteor.isClient  
  Tinytest.addAsync 'update - d3 clientside update of WI should update of target users WI if present'+new Date().getTime(), (test, next) ->
    Meteor.call 'dummyInsert' , (res,err) ->
      connect(recommendation)
    sense = Tracker.autorun (computation) ->
      if WI.findOne({to: 'elias'})
        smite eval(s), 'elias exists?'
        test.equal W.findOne({to:'elias'}).from , recFrom
        next()
        computation.stop()

if Meteor.isClient
  sent = Tracker.autorun (computation) ->
      if inboxed = WI.findOne({inbox:  { $exists : true } })
        smite eval(s), 'inbox exists?',
    
      if inboxed = WI.findOne({inbox:  { $exists : true } })
        smite eval(s), 'inbox exists', inboxed
        #Tinytest.addAsync 'update - 2 clientside update of WI should update of target users WI if present', (test, next) ->
        smite eval(s) , W.findOne({to:'elias'}) , WI.findOne({_id:'elias'})
        test.equal W.findOne({to:'elias'}) , WI.findOne({_id:'elias'})
        next()
        computation.stop()  
  Tinytest.addAsync 'update - e2 clientside update of WI should update of target users WI if present'+new Date().getTime(), (test, next) ->
    Meteor.call 'dummyInsert' , (res,err) ->
      sent()
    
    
###
###
if Meteor.isClient

  @recFrom = 'picture'
  recommendation =
      to: 'elias'
      from: recFrom
  smite eval(s), 'starting'
  Meteor.call 'dummyInsert', (req,res) ->
    smite eval(s), 'returned'
    Tinytest.addAsync 'update - clientside update of WI should update of target users WI if present', (test, next) ->
      smite eval(s), 'added'
      # update outbox serverside with minimal information.  
      connect(recommendation)
      smite eval(s), 'connected'
      #when client update synced to server, hook inserts w and w is synced to client tracker reruns
      picd = Tracker.autorun (computation) ->
        #TODO Exception from Tracker recompute function: Error: Can't call Tracker.flush while flushing
        # this doesn't affect the test but looks bad
        smite eval(s), 'ran tracker'
        # since the sync hasn't gone to server and back (hooks!) we test once the data is here
        unless !W.findOne({to:'elias'})
          smite eval(s), 'got hit'
          test.equal W.findOne({to:'elias'}).from , WI.findOne({_id:'elias'}).inbox[0].from
          next()
          computation.stop() # APPEARS not necessary
###
          