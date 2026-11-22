# Comparison: Original Proof vs. AI-Generated Lean Proof

## 1. Objective

The purpose of this comparison is to investigate whether an AI-generated Lean implementation faithfully preserves the mathematical reasoning of its original natural-language proof.

The experiment uses Problem 1 from the 2026 International Mathematics Competition (IMC):

$$
\cos(\cos x)=\sin(\sin x).
$$

The original proof was independently developed by the author before requesting its formalization.

Both proofs aim to establish that the equation has no real solution. However, their mathematical approaches differ in the way they derive and use the necessary constraints.

## 2. Original Natural-Language Proof

The original proof relies on trigonometric transformations involving the expressions:

$$
\sin x+\cos x
\qquad\text{and}\qquad
\sin x-\cos x.
$$

In particular, it uses the identities:

$$
\sin x+\cos x = \sqrt{2}\sin\left(x+\frac{\pi}{4}\right),
$$

and

$$
\sin x-\cos x = \sqrt{2}\sin\left(x-\frac{\pi}{4}\right).
$$

These transformations are used to derive constraints on the possible values of the expressions and ultimately obtain a contradiction involving an integer parameter.

The proof therefore follows a trigonometric approach based on angle transformations and the resulting restrictions on the integer parameter.

## 3. AI-Generated Lean Implementation

The AI model was given the following prompt:

> "Write Lean code that compiles for the following proof, and just give me the code."

The generated implementation was successfully accepted by the Lean kernel.

The proof begins by rewriting the cosine expression using:

$$
\cos(\cos x)=\sin\left(\frac{\pi}{2}-\cos x\right).
$$

It then applies the characterization of equality between two sine values, using `Real.sin_eq_sin_iff`, to obtain two possible cases involving an integer parameter $k$.

The implementation subsequently considers the expressions:

$$
\sin x+\cos x
$$

and

$$
\sin x-\cos x.
$$

For each case, it establishes a squared upper bound:

$$
(\sin x+\cos x)^2\leq 2,
$$

or

$$
(\sin x-\cos x)^2\leq 2.
$$

These bounds are obtained using algebraic reasoning and the non-negativity of squared expressions, automated through Lean's `nlinarith` tactic.

The implementation then establishes that, for every integer $k$,

$$
\left(\left(2k+\frac12\right)\pi\right)^2>2.
$$

This contradicts the upper bounds derived in the two cases.

## 4. Comparison of the Two Approaches

| Aspect | Original proof | AI-generated Lean proof |
|---|---|---|
| Initial approach | Trigonometric transformations | Trigonometric identity and sine equality characterization |
| Main expressions | $\sin x+\cos x$ and $\sin x-\cos x$ | $\sin x+\cos x$ and $\sin x-\cos x$ |
| Main technique | Angle transformations using $\pi/4$ | Algebraic inequalities and squared expressions |
| Integer parameter | Used to derive restrictions on possible values | Obtained through `Real.sin_eq_sin_iff` |
| Contradiction | Derived from the original trigonometric constraints | Derived from lower and upper bounds on squared expressions |

The comparison reveals that the generated implementation retains some of the mathematical structure of the original proof, particularly the use of the two expressions and an integer parameter.

However, it does not fully reproduce the original sequence of trigonometric transformations and deductions. Instead, it relies on algebraic inequalities to establish the contradiction.

## 5. Interpretation: Formal Correctness vs. Semantic Fidelity

The experiment illustrates two distinct properties of mathematical formalization.

**Formal correctness** concerns whether the proof assistant verifies that the formal argument establishes the specified proposition under its assumptions.

**Semantic fidelity** concerns whether the formal argument faithfully represents the mathematical reasoning contained in the original natural-language proof.

In this experiment, the generated Lean implementation satisfies the first criterion: it is successfully accepted by Lean.

However, it does not fully preserve the reasoning strategy of the original proof. Some of the original trigonometric reasoning is replaced by algebraic inequalities and automated nonlinear arithmetic.

This distinction requires an important qualification.

A different proof strategy is not inherently a mathematical error. If the objective is simply to prove a theorem, an alternative valid proof is entirely acceptable. However, if the objective is to formalize a particular mathematical argument, replacing parts of its reasoning raises a question of semantic fidelity.

The original prompt requested Lean code "for the following proof", suggesting an intention to formalize the supplied argument. Nevertheless, it did not explicitly prohibit alternative proof strategies.

## 6. Conclusion

This case study illustrates how an AI system can generate a formally valid Lean proof without fully preserving the mathematical reasoning of the original natural-language argument.

The generated proof establishes the required theorem, but its reasoning differs from the original approach in several steps.

This does not imply that the generated proof is mathematically incorrect. Rather, it demonstrates that successful formal verification alone cannot establish that a formal proof faithfully represents the mathematical argument it was intended to formalize.

The distinction between proving a theorem and formalizing a given proof is therefore essential when evaluating AI-driven autoformalization systems.
