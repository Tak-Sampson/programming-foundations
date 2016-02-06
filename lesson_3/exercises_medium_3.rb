# exercises_medium_3.rb

# 1

#  a_outer is 42 with an id of: 85 before the block.
#  b_outer is forty two with an id of: 70306891122500 before the block.
#  c_outer is [42] with an id of: 70306891122480 before the block.
#  d_outer is 42 with an id of: 85 before the block.

# (The id of 85 is reused when the value 42 is repeated)

#  a_outer id was 85 before the block and is: 85 inside the block.
#  b_outer id was 70306891122500 before the block and is: 70306891122500 inside the block.
#  c_outer id was 70306891122480 before the block and is: 70306891122480 inside the block.
#  d_outer id was 85 before the block and is: 85 inside the block.

# (No change in object id)

#  a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
#  b_outer inside after reassignment is thirty three with an id of: 70306891122500 before and: 70306891121780 after.
#  c_outer inside after reassignment is [44] with an id of: 70306891122480 before and: 70306891121760 after.
#  d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

# (Reassigning values to the variables created new objects with new ids)

#  a_inner is 22 with an id of: 45 inside the block (compared to 45 for outer).
#  b_inner is thirty three with an id of: 70306891121780 inside the block (compared to 70306891121780 for outer).
#  c_inner is [44] with an id of: 70306891121760 inside the block (compared to 70306891121760 for outer).
#  d_inner is 44 with an id of: 89 inside the block (compared to 89 for outer).

# (Objects and their are reused when able; i.e. when values are repeated)

#  a_outer is 22 with an id of: 85 BEFORE and: 45 AFTER the block.
#  b_outer is thirty three with an id of: 70306891122500 BEFORE and: 70306891121780 AFTER the block.
#  c_outer is [44] with an id of: 70306891122480 BEFORE and: 70306891121760 AFTER the block.
#  d_outer is 44 with an id of: 85 BEFORE and: 89 AFTER the block.

# (Variables a_outer, b_outer, etc were defined outside the block and can be accessed there)

# Nothing printed for final round of puts commands since a_inner, b_inner, etc were defined within the block

# 2

#  a_outer is 42 with an id of: 85 before the block.
#  b_outer is forty two with an id of: 70097905480200 before the block.
#  c_outer is [42] with an id of: 70097905480120 before the block.
#  d_outer is 42 with an id of: 85 before the block.

# (Same as before, though b_outer and c_outer have new objects and ids; a_outer, d_outer are reused)

#  a_outer id was 85 before the method and is: 85 inside the method.
#  b_outer id was 70097905480200 before the method and is: 70097905480200 inside the method.
#  c_outer id was 70097905480120 before the method and is: 70097905480120 inside the method.
#  d_outer id was 85 before the method and is: 85 inside the method.

# (Calling the method creates new varibales within the method, but with the same values, so objects are reused)

#  a_outer inside after reassignment is 22 with an id of: 85 before and: 45 after.
#  b_outer inside after reassignment is thirty three with an id of: 70097905480200 before and: 70097905465620 after.
#  c_outer inside after reassignment is [44] with an id of: 70097905480120 before and: 70097905465380 after.
#  d_outer inside after reassignment is 44 with an id of: 85 before and: 89 after.

# (As before, changing the variables creates new objects for them to point to)

#  a_inner is 22 with an id of: 45 inside the method (compared to 45 for outer).
#  b_inner is thirty three with an id of: 70097905465620 inside the method (compared to 70097905465620 for outer).
#  c_inner is [44] with an id of: 70097905465380 inside the method (compared to 70097905465380 for outer).
#  d_inner is 44 with an id of: 89 inside the method (compared to 89 for outer).

# (Again, objects are reused for the same values)

#  a_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.
#  b_outer is forty two with an id of: 70097905480200 BEFORE and: 70097905480200 AFTER the method call.
#  c_outer is [42] with an id of: 70097905480120 BEFORE and: 70097905480120 AFTER the method call.
#  d_outer is 42 with an id of: 85 BEFORE and: 85 AFTER the method call.

# (Variables outside the method are left unchanged since they are independent of the parameter
#  variables within the method. The method call accepted the values of the local variables, but
#  any changes applied within were applied to the paraemter variables instead.)

# Once again, nothing printed due to variable scoping

# 3

# My string looks like this now: pumpkins

# (The value of my_string is accepted by the method call, and although the parameter variable is
#  changed, += does not mutate the caller, leaving my_string unaltered.)

# My array looks like this now: ["pumpkins", "rutabaga"]

# (<< mutates the caller, so the object pointed to by the local variable my_array is changed to
#  ["pumpkins", "rutabaga"].)

# 4

# My string looks like this now: rutabaga

# (This time the method gsub! alters the object pointed to by the parameter variable a_string_param,
#  which is the same object that my_string points to since its value was accepted by the method call)

# My array looks like this now: ["pumpkins"]

# (Unlike last time, setting an_array_param = ['pumpkins', 'rutabaga'] merely changes what the parameter
#  variable points to, leaving the object pointed to by the local variable unchanged.)

# 5

def color_valid(color)
  color == "blue" || color == "green"
end
