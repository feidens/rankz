# The "||" notation doesn't work yet
@Fixtures = (if typeof Fixtures isnt "undefined" then Fixtures else {})
@Fixtures.dummyFixture = [
  {
    foo: "bar"
  }
  {
    foo2: "bar2"
    another: "value"
  }
]
# {
#   brand: "TestBrand"
#   productLine: "TestLine"
#   category: "TestCategory"
#   chest: 0
#   waist: 0
#   hip: 0
# }
