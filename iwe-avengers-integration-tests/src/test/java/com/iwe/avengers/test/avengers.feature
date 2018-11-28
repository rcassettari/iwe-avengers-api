Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://5q6yqm7ba3.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Create Avenger 

Given path 'avengers'
And request {name:'Iron Man', secretIdentity:'Tony Stark'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

* def savedAvenger = response

Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match response == savedAvenger

Scenario: Must return 400 for invalid creation payload 

Given path 'avengers'
And request {secretIdentity:'Tony Stark'}
When method post
Then status 400

Scenario: Must delete Avenger by id

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method delete 
Then status 204

Scenario: Must update Avenger by id

Given path 'avengers', 'aaaa-bbbb-cccc-dddd'
And request {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man', secretIdentity: 'Tony Stark'}

Scenario: Must return 400 for invalid update payload 

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {secretIdentity:'Tony Stark'}
When method put
Then status 400

Scenario: Should return not found Avenger

Given path 'avengers','not-found-id'
When method get
Then status 404

Scenario: Should return not found Avenger for a attempt do update

Given path 'avengers','not-found-id'
And request {name:'Iron Man' , secretIdentity: 'Tony Stark'}
When method put
Then status 404

Scenario: Should return not found Avenger for a attempt to delete

Given path 'avengers','not-found-id'
When method delete
Then status 404





















