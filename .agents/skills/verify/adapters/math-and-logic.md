# Adapter — Mathematics, Logic, and Calculations

Use when verifying derivations, equations, numerical calculations, algorithms, proofs, logical consistency, or model assumptions.

## Checks

- State assumptions, domains, units, conventions, and boundary conditions.
- Recompute the result independently when feasible.
- Check dimensions/types and sign conventions.
- Test edge cases, limiting cases, and counterexamples.
- Distinguish exact symbolic results from numerical approximations.
- For code-assisted calculations, record the code/command and precision/seed/environment where relevant.

## Verdict caveats

- Algebraic consistency under unstated assumptions is not a full `PASS`. Mark as `AMBIGUOUS` or `PARTIAL` if the domain, branch cut, convention, precision, or theorem dependency is unresolved.
- A numerical match is not proof of a general theorem.
- A formal proof can fail because of one hidden quantifier, boundary condition, or non-generic case.
