local util = require "sat_util"

--[[ This function takes in a list of atoms (variables) and a boolean expression
in conjunctive normal form. It should return a mapping from atom to booleans that
represents an assignment which satisfies the expression. If no assignments exist,
return nil. ]]--
function satisfiable(atoms, cnf)
  local function helper(assignment, clauses)
    if #clauses == 0 then
      for _, a in ipairs(atoms) do
        if assignment[a] == nil then
          assignment[a] = true
        end
      end
      return assignment
    else
      local clauses_copy = util.deep_copy(clauses)
      local clause = table.remove(clauses_copy, 1)
      for _, c in ipairs(clause) do
        local curr_a = c[1]
        local affinity = c[2]
        local assignment_copy = util.deep_copy(assignment)
        if assignment[curr_a] == nil or assignment[curr_a] == affinity then
          assignment_copy[curr_a] = affinity
          local result = helper(assignment_copy, clauses_copy)
          if result ~= nil then
            return result
          end
        end
      end
      return
    end
  end

  return helper({}, cnf)
end

function get_table_len(table)
  local count = 0
  for i,e in pairs(table) do
    count = count + 1
  end
  return count
end

--[[ The function above only returns one solution. This function should return
an iterator which calculates, on demand, all of the solutions. ]]--
function satisfiable_gen(atoms, cnf)
  local function helper (assignment, clauses)
    if #clauses == 0 then
      if get_table_len(assignment) == #atoms then
        coroutine.yield(assignment)
      else
        for _, a in ipairs(atoms) do
          if assignment[a] == nil then
            assignment_copy_1 = util.deep_copy(assignment)
            assignment_copy_1[a] = true
            helper(assignment_copy_1, clauses)
            assignment_copy_2 = util.deep_copy(assignment)
            assignment_copy_2[a] = false
            helper(assignment_copy_2, clauses)
          end
        end
      end
    else
      local clauses_copy = util.deep_copy(clauses)
      local clause = table.remove(clauses_copy, 1)
      for _, c in ipairs(clause) do
        local curr_a = c[1]
        local affinity = c[2]
        local assignment_copy = util.deep_copy(assignment)
        if assignment[curr_a] == nil or assignment[curr_a] == affinity then
          assignment_copy[curr_a] = affinity
          local result = helper(assignment_copy, clauses_copy)
          if result ~= nil then
            return result
          end
        end
      end
      return
    end
  end

  local solutions = coroutine.wrap(function ()
    helper({}, cnf)
  end)

  --[[ We've provided a wrapper which removes duplicate solutions so that
  your solver doesn't need to check for duplicates before emitting a result. ]]--
  return util.iter_dedup(solutions)
end

util.run_basic_tests()
