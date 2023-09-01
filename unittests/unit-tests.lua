module(..., package.seeall)  -- need this to make things visible 

function testAdd() 

	assert_equal(add(2,2), 4) 

end