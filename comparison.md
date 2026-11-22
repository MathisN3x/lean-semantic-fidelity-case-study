# Comparison: Original Proof vs. AI-Generated Lean Proof

## 1. Objective

The purpose of this comparison is to investigate whether an AI-generated Lean implementation faithfully preserves the mathematical reasoning of its original natural-language proof.

The experiment uses Problem 1 from the 2026 International Mathematics Competition (IMC):

$$
\cos(\cos x)=\sin(\sin x).
$$

The original proof was independently developed by the author before requesting its formalization.

Both proofs aim to establish that the equation has no real solution. Although they share part of their mathematical structure, they differ in the techniques used to derive the final contradiction.

## 2. Original Natural-Language Proof

The original proof begins by rewriting the equation using the identity

$$
\cos X=\sin\left(\frac{\pi}{2}-X\right).
$$

It then applies the characterization of equality between two sine values:

$$
\sin X=\sin Y
\iff
\begin{cases}
X=Y+2k\pi,\\
\text{or}\\
X=\pi-Y+2k\pi,
\end{cases}
\qquad k\in\mathbb Z.
$$

This leads to two possible cases:

$$
\sin x+\cos x=\frac{\pi}{2}-2k\pi
\tag{1}
$$

or

$$
\sin x-\cos x=\frac{\pi}{2}+2k\pi.
\tag{2}
$$

The original proof then treats these cases separately.

### Case 1

It uses the trigonometric identity

$$
\sin x+\cos x =\sqrt{2}\sin\left(x+\frac{\pi}{4}\right).
$$

Since the sine function is bounded by $-1$ and $1$, it obtains

$$
-1\leq
\frac{\sqrt{2}}{2}
\left(\frac{\pi}{2}-2k\pi\right)
\leq 1.
$$

After rearranging, this gives

$$
\frac{\pi-2\sqrt{2}}{4\pi}
\leq k\leq
\frac{\pi+2\sqrt{2}}{4\pi}.
$$

Using elementary inequalities involving $\pi$ and $\sqrt{2}$, the proof establishes

$$
0 < k <1.
$$

This is impossible because $k$ is an integer.

### Case 2

Similarly, the proof uses

$$
\sin x-\cos x=\sqrt{2}\sin\left(x-\frac{\pi}{4}\right).
$$

The bound on the sine function gives

$$
-\sqrt{2}
\leq
\frac{\pi}{2}+2k\pi
\leq \sqrt{2}.
$$

Rearranging yields

$$
\frac{-\pi-2\sqrt{2}}{4\pi}
\leq k\leq
\frac{-\pi+2\sqrt{2}}{4\pi}.
$$

The inequalities involving $\pi$ and $\sqrt{2}$ then imply

$$
-1 < k <0,
$$

which is also impossible for an integer.

Thus, neither case can occur.

## 3. AI-Generated Lean Implementation

The AI model was given the following prompt:

> "Write Lean code that compiles for the following proof, and just give me the code."

The generated implementation was successfully accepted by the Lean kernel.

The proof first rewrites the cosine expression using

$$
\cos(\cos x) =\sin\left(\frac{\pi}{2}-\cos x\right).
$$

It then uses `Real.sin_eq_sin_iff` to obtain two possible cases involving an integer parameter.

The implementation subsequently establishes the following general result:

$$
\forall m\in\mathbb Z,\qquad
\left(\left(2m+\frac12\right)\pi\right)^2>2.
$$

To establish this result, it first proves

$$
\left(2m+\frac12\right)^2\geq\frac14.
$$

This follows from the fact that $2m+\frac12$ is a half-integer and therefore cannot have an absolute value smaller than $\frac12$.

It also uses

$$
\pi>3
\quad\Longrightarrow\quad
\pi^2>9.
$$

Combining these inequalities gives

$$
\left(2m+\frac12\right)^2\pi^2\geq \frac{\pi^2}{4}> \frac94>2.
$$

The proof then considers the two branches separately.

In the first branch, it establishes

$$
(\sin x+\cos x)^2\leq 2.
$$

In the second branch, it establishes

$$
(\sin x-\cos x)^2\leq 2.
$$

These bounds follow from the identity

$$
\sin^2 x+\cos^2 x=1
$$

and the non-negativity of squared expressions.

The equalities obtained from `Real.sin_eq_sin_iff` identify the corresponding expressions with a quantity of the form

$$
\left(2m+\frac12\right)\pi.
$$

This contradicts the previously established lower bound.

The contradictions are discharged using Lean's `nlinarith` tactic.

## 4. Comparison of the Two Approaches

| Aspect | Original proof | AI-generated Lean proof |
|---|---|---|
| Initial transformation | Converts cosine into sine | Same transformation |
| Equality of sine values | Derives two cases using the sine characterization | Uses `Real.sin_eq_sin_iff` |
| Main expressions | $\sin x+\cos x$ and $\sin x-\cos x$ | Same expressions |
| Treatment of the expressions | Angle transformations involving $\pi/4$ | Algebraic manipulation of squared expressions |
| Main inequalities | Bounds derived from $-1\leq\sin t\leq1$ | Bounds on squared expressions |
| Treatment of the integer | Shows that $k$ belongs to an interval containing no integer | Establishes a lower bound for the square of a half-integer multiple of $\pi$ |
| Final contradiction | Excludes integer values in $(0,1)$ and $(-1,0)$ | Contradicts the upper bounds of $2$ |

The comparison reveals that the generated implementation preserves several structural elements of the original proof.

In particular, both approaches:

- Start from the same trigonometric transformation.
- Obtain two possible cases.
- Introduce an integer parameter.
- Examine the expressions $\sin x+\cos x$ and $\sin x-\cos x$.
- Derive a contradiction in each case.

However, the methods used to establish the contradictions are different.

The original proof relies on trigonometric angle transformations and interval constraints on the integer parameter. The Lean implementation instead uses algebraic inequalities involving squared expressions and a lower bound for the square of a half-integer multiple of $\pi$.

Therefore, the generated implementation preserves part of the original mathematical structure but does not fully reproduce its reasoning strategy.

## 5. Interpretation: Formal Correctness vs. Semantic Fidelity

This experiment illustrates two distinct properties of mathematical formalization.

**Formal correctness** concerns whether the proof assistant verifies that the formal argument establishes the specified proposition under its assumptions.

**Semantic fidelity** concerns whether the formal argument faithfully represents the mathematical reasoning contained in the original natural-language proof.

In this experiment, the generated Lean implementation satisfies the first criterion: it is successfully accepted by Lean.

However, it does not fully preserve the original reasoning strategy. In particular, the trigonometric transformations used to derive the integer intervals are replaced by algebraic inequalities.

This distinction requires an important qualification.

A different proof strategy is not inherently a mathematical error. If the objective is simply to prove a theorem, an alternative valid proof is entirely acceptable. However, if the objective is to formalize a particular mathematical argument, replacing its reasoning raises a question of semantic fidelity.

The original prompt requested Lean code "for the following proof", suggesting an intention to formalize the supplied argument. Nevertheless, it did not explicitly prohibit alternative proof strategies.

## 6. Conclusion

This case study illustrates how an AI system can generate a formally valid Lean proof without fully preserving the mathematical reasoning of the original natural-language argument.

The generated implementation retains the overall structure of the proof, including its two cases and the expressions involved, but replaces the original method for deriving the final contradictions.

This does not imply that the generated proof is mathematically incorrect. Rather, it demonstrates that successful formal verification alone cannot establish that a formal proof faithfully represents the mathematical argument it was intended to formalize.

The distinction between proving a theorem and formalizing a given proof is therefore essential when evaluating AI-driven autoformalization systems.
