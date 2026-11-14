/-
「辺の重複がない閉歩道の位相は二次符号と横断数で決まる」（`claim_edge_distinct_walk_quadratic_sign`）の
必要十分版。具体版 `edgeDistinctWalk_quadraticSign` の二つ目の式鎖と同じ五段
（ねじれ符号の積、族への分割と整数指数の加法則、各項の等式、族の二次符号の加法則、横断数の偶奇）を、
係数の住処と閉歩道の族を抽象化して書く。

仮定は具体版が前の主張から得る事実だけである:
- `htwist`: ねじれ符号の積は `(−1)^{a h + b v}`（`claim_walk_twist_sign_product`）。
- `hturn`・`hseamH`・`hseamV`・`hcross`: 横断消去の族の回転数の和・切断線偶奇の和・横断数の偶奇
  （`claim_edge_distinct_crossing_elimination_parity`）。
- `hmember`: 族の各項の位相は二次符号（証明の前半）。
- `hfamily`: 族の二次符号の加法則の反復（`claim_torus_quadratic_sign_polarization` と `claim_even_edge_chain_intersection`）。

係数の住処には体を仮定する。削れない理由: 回転数は負にもなる整数なので、`ζ_8^{Σ t_i} = Π ζ_8^{t_i}` に
`ζ_8` の逆元が要る（`hz : z ≠ 0` と `zpow_add₀`）。`(−1)^{n−1}` を有限積の外へ出し、
`(−1)^P` と `χ` を並べ替えるのに積の可換性が要る。`(−1)` と符号の掛け算に環の演算が要る。
切断線偶奇の読みは二を法とした余りで、`𝔽₂` の値 `P` の整数代表 `ZMod.val` を指数に使う。
-/
import Mathlib.Algebra.Field.Basic
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Algebra.BigOperators.Group.List.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

/-- `(−1)` の冪の指数は二を法として読める。 -/
theorem neg_one_pow_mod_two_necSuf {K : Type*} [Ring K] (n : ℕ) :
    (-1 : K) ^ n = (-1 : K) ^ (n % 2) := by
  conv_lhs => rw [← Nat.mod_add_div n 2]
  rw [pow_add, pow_mul, neg_one_sq, one_pow, mul_one]

/-- `(−1)` の冪の平方は `1`。 -/
theorem neg_one_pow_mul_self_necSuf {K : Type*} [CommRing K] (n : ℕ) :
    (-1 : K) ^ n * (-1 : K) ^ n = 1 := by
  rw [← mul_pow]; norm_num

theorem edge_distinct_walk_quadratic_sign_necSuf {K W : Type*} [Field K]
    (z : K) (hz : z ≠ 0) (a b : ℕ)
    (sH sV : W → ℕ) (t : W → ℤ) (χ : W → K)
    (ds : List W) (hne : ds ≠ [])
    (εprod χγ : K) (Hγ Vγ cγ : ℕ) (tγ : ℤ) (P : ZMod 2)
    (htwist : εprod = (-1 : K) ^ (a * Hγ + b * Vγ))
    (hturn : (ds.map t).sum = tγ)
    (hseamH : (ds.map sH).sum % 2 = Hγ % 2) (hseamV : (ds.map sV).sum % 2 = Vγ % 2)
    (hmember : ∀ d ∈ ds, -((-1 : K) ^ (a * sH d + b * sV d)) * z ^ t d = χ d)
    (hfamily : χγ = (-1 : K) ^ P.val * (ds.map χ).prod)
    (hcross : (cγ : ZMod 2) = ((ds.length - 1 : ℕ) : ZMod 2) + P) :
    -εprod * z ^ tγ = χγ * (-1 : K) ^ cγ := by
  obtain ⟨k, hk⟩ : ∃ k, ds.length = k + 1 :=
    ⟨ds.length - 1, (Nat.succ_pred_eq_of_pos (List.length_pos_iff.mpr hne)).symm⟩
  -- 整数指数の加法則と符号付きの有限積の展開
  have hzsum : ∀ es : List W, z ^ (es.map t).sum = (es.map fun d => z ^ t d).prod := by
    intro es
    induction es with
    | nil => simp
    | cons d es ih =>
      simp only [List.map_cons, List.sum_cons, List.prod_cons]
      rw [zpow_add₀ hz, ih]
  have hphase : ∀ es : List W,
      (es.map fun d => -((-1 : K) ^ (a * sH d + b * sV d)) * z ^ t d).prod =
        (-1 : K) ^ (es.length + (a * (es.map sH).sum + b * (es.map sV).sum)) *
          (es.map fun d => z ^ t d).prod := by
    intro es
    induction es with
    | nil => simp
    | cons d es ih =>
      simp only [List.map_cons, List.prod_cons, List.length_cons, List.sum_cons, ih]
      simp only [pow_add, pow_one, Nat.mul_add, pow_add]
      ring
  have hmod : (-1 : K) ^ (a * Hγ + b * Vγ) =
      (-1 : K) ^ (a * (ds.map sH).sum + b * (ds.map sV).sum) := by
    rw [neg_one_pow_mod_two_necSuf (a * Hγ + b * Vγ),
      neg_one_pow_mod_two_necSuf (a * (ds.map sH).sum + b * (ds.map sV).sum)]
    congr 1
    rw [Nat.add_mod, Nat.mul_mod, ← hseamH, Nat.mul_mod b, ← hseamV, ← Nat.mul_mod, ← Nat.mul_mod,
      ← Nat.add_mod]
  have hval : ∀ x y : ZMod 2, (-1 : K) ^ (x + y).val = (-1 : K) ^ x.val * (-1 : K) ^ y.val := by
    intro x y
    rw [ZMod.val_add, ← pow_add, ← neg_one_pow_mod_two_necSuf]
  have hcast : ∀ n : ℕ, (-1 : K) ^ ((n : ZMod 2)).val = (-1 : K) ^ n := by
    intro n
    rw [ZMod.val_natCast, ← neg_one_pow_mod_two_necSuf]
  calc -εprod * z ^ tγ
      -- ねじれ符号の積
      = -((-1 : K) ^ (a * Hγ + b * Vγ)) * z ^ tγ := by rw [htwist]
      -- 族への分割と整数指数の加法則
    _ = (-1 : K) ^ k * (ds.map fun d => -((-1 : K) ^ (a * sH d + b * sV d)) * z ^ t d).prod := by
        rw [hphase, ← hturn, hzsum, hk, hmod, pow_add (-1 : K) (k + 1), pow_succ (-1 : K) k]
        linear_combination ((-1 : K) ^ (a * (ds.map sH).sum + b * (ds.map sV).sum) *
          (ds.map fun d => z ^ t d).prod) * neg_one_pow_mul_self_necSuf (K := K) k
      -- 各項の等式
    _ = (-1 : K) ^ k * (ds.map χ).prod := by
        congr 2
        exact List.map_congr_left hmember
      -- 族の二次符号の加法則
    _ = (-1 : K) ^ k * ((-1 : K) ^ P.val * χγ) := by
        rw [hfamily]
        linear_combination (-((-1 : K) ^ k * (ds.map χ).prod)) * neg_one_pow_mul_self_necSuf (K := K) P.val
      -- 横断数の偶奇
    _ = χγ * (-1 : K) ^ cγ := by
        rw [← hcast cγ, hcross, hk, Nat.add_sub_cancel, hval, hcast]
        ring

end Ising2DLambda.NecSuf.KacWard
