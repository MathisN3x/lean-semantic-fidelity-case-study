import Mathlib

open Real

theorem cos_cos_ne_sin_sin (x : ℝ) : Real.cos (Real.cos x) ≠ Real.sin (Real.sin x) := by
  intro h
  have h1 : Real.cos (Real.cos x) = Real.sin (π / 2 - Real.cos x) := by
    rw [Real.sin_pi_div_two_sub]
  rw [h1] at h
  obtain ⟨k, hk⟩ := Real.sin_eq_sin_iff.mp h
  have hpi : (3 : ℝ) < π := Real.pi_gt_three
  have hp2 : (9 : ℝ) < π ^ 2 := by nlinarith
  have hsc := Real.sin_sq_add_cos_sq x
  -- no integer m makes ((2m + 1/2) π)^2 ≤ 2
  have key : ∀ m : ℤ, ¬ (((2 : ℝ) * m + 1 / 2) * π) ^ 2 ≤ 2 := by
    intro m hm
    have hm' : (1 : ℝ) / 4 ≤ ((2 : ℝ) * m + 1 / 2) ^ 2 := by
      by_cases h0 : 0 ≤ m
      · have : (0 : ℝ) ≤ m := by exact_mod_cast h0
        nlinarith [sq_nonneg (m : ℝ)]
      · have h3 : m ≤ -1 := by omega
        have : (m : ℝ) ≤ -1 := by exact_mod_cast h3
        nlinarith
    have h4 : (((2 : ℝ) * m + 1 / 2) * π) ^ 2 = ((2 : ℝ) * m + 1 / 2) ^ 2 * π ^ 2 := by
      ring
    have h5 : (1 : ℝ) / 4 * π ^ 2 ≤ ((2 : ℝ) * m + 1 / 2) ^ 2 * π ^ 2 :=
      mul_le_mul_of_nonneg_right hm' (by positivity)
    linarith
  rcases hk with hk | hk
  · -- sin x + cos x = (2k + 1/2) π
    have hle : (Real.sin x + Real.cos x) ^ 2 ≤ 2 := by
      nlinarith [sq_nonneg (Real.sin x - Real.cos x)]
    have e : ((2 : ℝ) * k + 1 / 2) * π = Real.sin x + Real.cos x := by
      linarith
    apply key k
    rw [e]
    exact hle
  · -- sin x - cos x = (2k + 1/2) π
    have hle : (Real.sin x - Real.cos x) ^ 2 ≤ 2 := by
      nlinarith [sq_nonneg (Real.sin x + Real.cos x)]
    have e : ((2 : ℝ) * k + 1 / 2) * π = Real.sin x - Real.cos x := by
      linarith
    apply key k
    rw [e]
    exact hle
