local util = require "sat_util"

--[[ This function takes in a list of atoms (variables) and a boolean expression
in conjunctive normal form. It should return a mapping from atom to booleans that
represents an assignment which satisfies the expression. If no assignments exist,
return nil. ]]--
function satisfiable(atoms, cnf)
  local function helper(assignment, clauses)
    -- Your code goes here.
    -- You may find util.deep_copy useful.
  end

  return helper({}, cnf)
end

--[[ The function above only returns one solution. This function should return
an iterator which calculates, on demand, all of the solutions. ]]--
function satisfiable_gen(atoms, cnf)
  local function helper (assignment, clauses)
    -- Your code goes here.
    -- You may find util.deep_copy useful.
  end

  local solutions = coroutine.wrap(function ()
    helper({}, cnf)
  end)

  --[[ We've provided a wrapper which removes duplicate solutions so that
  your solver doesn't need to check for duplicates before emitting a result. ]]--
  return util.iter_dedup(solutions)
end

util.run_basic_tests()
