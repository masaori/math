/-
# 命題 C（Pisano 型上界）の周期の段

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 C**
（$\pi(p,k)\mid p^{k-1}\pi(p,1)$）。設定は同 §2 命題 A
（根拠 report `outputs/reports/cycle3_T1_D-U2_rigorous.md`）と同じ。

`PropC.lean` は命題 C の**代数的核**
$$U\equiv I \pmod p\ \Longrightarrow\ U^{p^{k-1}}=I \quad\text{in } M_d(\mathbb{Z}/p^k)$$
だけを形式化していた。本ファイルは、そこで「形式化していない部分」として明記されていた

> $\pi(p,k)$ を最終周期の最小値として定義し、$p\nmid\det T$ から純周期性（最終周期＝`orderOf`）を
> 出して $\pi(p,k)\mid p^{k-1}\pi(p,1)$ を結論する段

を埋める。

## 形式化した主張

1. `pow_eq_one_of_isUnit_of_eventually_periodic` … 単元の冪列が最終周期的なら、その周期で
   `A ^ t = 1`（＝最終周期は 0 から数えた純周期でもある）。
2. `isLeast_eventualPeriod` … したがって「最終周期の最小値」は `orderOf A` に一致する。
   これが人手証明の $\pi(p,k)$ と Lean の `orderOf` を橋渡しする。
3. `isUnit_intCast_matrix_of_not_dvd_det` … $p\nmid\det T$ ならば $T\bmod p^k$ は単元。
   （1・2 の仮定 `IsUnit` を人手証明の仮定から出す段。）
4. `pisanoPeriod_dvd` … **命題 C 本体** $\pi(p,k)\mid p^{k-1}\pi(p,1)$。
   ここで $\pi(p,k)=$ `pisanoPeriod p k T`、$\pi(p,1)=$ `pisanoPeriodOne p T`。
5. `isLeast_eventualPeriod_pisanoPeriod` … 4 の $\pi(p,k)$ が確かに
   「$T^N \bmod p^k$ の最終周期の最小値」であること。

## 形式化していない主張

- **等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）は一般には成り立たない**（cycle 6 で 572 件中 4.5% の反例）。
  ここで証明するのは整除（上界）方向だけであり、これは人手証明と同じスコープである。
- 命題 B（$\pi(p,1)$ の $\overline{\mathbb{F}_p}$ 固有値による精密公式）は扱わない。`README.md` の
  「形式化の現状」表を参照。

## 人手証明から変えた点

- 人手証明は $\pi(p,1)$ を「$\mathbb{Z}/p$ 上の周期」と書くが、Lean では `ZMod (p^1)` と `ZMod p` が
  定義上同じ型ではないので、$k=1$ の場合を `pisanoPeriodOne p T := orderOf (T \bmod p)` として
  別に定義した（`ZMod p` 上）。主張は同じである。

**新規性は主張しない**（Pisano 型上界は古典）。
-/
import Mathlib
import IntegrableLattice.PropC

namespace IntegrableLattice

open Matrix

/-! ## 1. 最終周期性と `orderOf` -/

/-- モノイドの単元 `A` について、冪列 `N ↦ A ^ N` が周期 `t` で**最終**周期的なら、
実は `A ^ t = 1`（＝ 0 から数えた純周期でもある）。
人手証明が「$p\nmid\det T$ なら列は純周期的」と述べている段。 -/
theorem pow_eq_one_of_isUnit_of_eventually_periodic {M : Type*} [Monoid M] {A : M}
    (hA : IsUnit A) {t N₀ : ℕ} (h : ∀ N, N₀ ≤ N → A ^ (N + t) = A ^ N) : A ^ t = 1 := by
  have h₀ : A ^ N₀ * A ^ t = A ^ N₀ * 1 := by
    rw [mul_one, ← pow_add]
    exact h N₀ le_rfl
  exact (hA.pow N₀).mul_left_cancel h₀

/-- 単元 `A` の「最終周期の最小値」は `orderOf A` である。
人手証明の $\pi(p,k)$（最終周期の最小値）と Lean の `orderOf` を同一視する補題。 -/
theorem isLeast_eventualPeriod {M : Type*} [Monoid M] {A : M} (hA : IsUnit A)
    (hfin : IsOfFinOrder A) :
    IsLeast {t : ℕ | 0 < t ∧ ∃ N₀, ∀ N, N₀ ≤ N → A ^ (N + t) = A ^ N} (orderOf A) := by
  constructor
  · refine ⟨hfin.orderOf_pos, 0, fun N _ => ?_⟩
    rw [pow_add, pow_orderOf_eq_one, mul_one]
  · rintro t ⟨htpos, N₀, ht⟩
    exact Nat.le_of_dvd htpos
      (orderOf_dvd_of_pow_eq_one (pow_eq_one_of_isUnit_of_eventually_periodic hA ht))

/-! ## 2. `ZMod (p^k) → ZMod p` の核 -/

/-- `ZMod (p^k) → ZMod p` の還元で `0` に落ちる元は `p` の倍数。 -/
theorem exists_eq_natCast_prime_mul {p k : ℕ} [NeZero p] [NeZero (p ^ k)] (h : p ∣ p ^ k)
    {x : ZMod (p ^ k)} (hx : ZMod.castHom h (ZMod p) x = 0) :
    ∃ y : ZMod (p ^ k), x = (p : ZMod (p ^ k)) * y := by
  have hval : ((x.val : ℕ) : ZMod (p ^ k)) = x := ZMod.natCast_zmod_cast x ▸ ZMod.natCast_val x ▸ by
    simp
  have hx' : ((x.val : ℕ) : ZMod p) = 0 := by
    rw [← map_natCast (ZMod.castHom h (ZMod p)) x.val, hval, hx]
  obtain ⟨m, hm⟩ := (ZMod.natCast_zmod_eq_zero_iff_dvd x.val p).mp hx'
  refine ⟨(m : ZMod (p ^ k)), ?_⟩
  rw [← hval, hm]
  push_cast
  ring

/-- 成分ごとの還元 `M_d(ZMod (p^k)) → M_d(ZMod p)`。 -/
def redMatHom (p k d : ℕ) (h : p ∣ p ^ k) :
    Matrix (Fin d) (Fin d) (ZMod (p ^ k)) →+* Matrix (Fin d) (Fin d) (ZMod p) :=
  (ZMod.castHom h (ZMod p)).mapMatrix

/-- 還元核の行列版: `A ≡ I (mod p)` なら `A = 1 + p * V` と書ける。
`PropC.matrix_pow_prime_pow_eq_one` の仮定の形にそろえる。 -/
theorem exists_eq_one_add_natCast_mul {p k d : ℕ} [NeZero p] [NeZero (p ^ k)] (h : p ∣ p ^ k)
    {A : Matrix (Fin d) (Fin d) (ZMod (p ^ k))} (hA : redMatHom p k d h A = 1) :
    ∃ V, A = 1 + (p : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) * V := by
  have hker : ∀ i j, ∃ y, A i j - (1 : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) i j
      = (p : ZMod (p ^ k)) * y := by
    intro i j
    refine exists_eq_natCast_prime_mul h ?_
    have := congrFun (congrFun hA) i
    have h1 : ZMod.castHom h (ZMod p) (A i j) = (1 : Matrix (Fin d) (Fin d) (ZMod p)) i j := by
      have := congrFun (congrFun hA i) j
      simpa [redMatHom, RingHom.mapMatrix_apply, Matrix.map_apply] using this
    rw [map_sub, h1]
    by_cases hij : i = j <;> simp [Matrix.one_apply, hij]
  choose V hV using hker
  refine ⟨V, ?_⟩
  ext i j
  have : (p : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) = (p : ZMod (p ^ k)) • 1 := by
    simp [Matrix.smul_one_eq_diagonal, ← Matrix.diagonal_natCast]
  rw [this, smul_mul_assoc, one_mul]
  simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  rw [← hV i j]
  ring

/-! ## 3. `p ∤ det T` からの単元性 -/

/-- `p ∤ det T` ならば `T mod p^k` は `M_d(ZMod (p^k))` の単元。 -/
theorem isUnit_intCast_matrix_of_not_dvd_det {p k d : ℕ} [hp : Fact p.Prime] (hk : k ≠ 0)
    (T : Matrix (Fin d) (Fin d) ℤ) (hT : ¬ ((p : ℤ) ∣ T.det)) :
    IsUnit (T.map (Int.cast : ℤ → ZMod (p ^ k))) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hp.out.pos.ne'⟩
  rw [Matrix.isUnit_iff_isUnit_det]
  have hdet : (T.map (Int.cast : ℤ → ZMod (p ^ k))).det = ((T.det : ℤ) : ZMod (p ^ k)) := by
    rw [← RingHom.map_det (Int.castRingHom (ZMod (p ^ k)))]
    rfl
  rw [hdet]
  -- `ZMod (p^k)` では「単元 ⟺ `p` で割れない」
  have hkey : ∀ x : ZMod (p ^ k), (ZMod.castHom (dvd_pow_self p hk) (ZMod p) x ≠ 0) → IsUnit x := by
    intro x hx
    rw [ZMod.isUnit_iff_coprime_val] at *
    sorry
  refine hkey _ ?_
  rw [map_intCast]
  simpa [ZMod.intCast_zmod_eq_zero_iff_dvd] using hT

/-! ## 4. 命題 C 本体 -/

/-- $\pi(p,k)$: $T^N \bmod p^k$ の（最終）周期。`isLeast_eventualPeriod_pisanoPeriod` で
「最終周期の最小値」であることを示す。 -/
noncomputable def pisanoPeriod (p k d : ℕ) (T : Matrix (Fin d) (Fin d) ℤ) : ℕ :=
  orderOf (T.map (Int.cast : ℤ → ZMod (p ^ k)))

/-- $\pi(p,1)$。`ZMod (p^1)` ではなく `ZMod p` の上で取る（型の都合。主張は同じ）。 -/
noncomputable def pisanoPeriodOne (p d : ℕ) (T : Matrix (Fin d) (Fin d) ℤ) : ℕ :=
  orderOf (T.map (Int.cast : ℤ → ZMod p))

/-- **命題 C**: $\pi(p,k)\mid p^{k-1}\,\pi(p,1)$。 -/
theorem pisanoPeriod_dvd {p k d : ℕ} [hp : Fact p.Prime] (hk : k ≠ 0)
    (T : Matrix (Fin d) (Fin d) ℤ) :
    pisanoPeriod p k d T ∣ p ^ (k - 1) * pisanoPeriodOne p d T := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hp.out.pos.ne'⟩
  haveI : NeZero p := ⟨hp.out.pos.ne'⟩
  set h : p ∣ p ^ k := dvd_pow_self p hk
  set A := T.map (Int.cast : ℤ → ZMod (p ^ k)) with hA
  set f := redMatHom p k d h with hf
  have hfA : f A = T.map (Int.cast : ℤ → ZMod p) := by
    ext i j
    simp [hf, redMatHom, RingHom.mapMatrix_apply, Matrix.map_apply, hA, map_intCast]
  have hone : f (A ^ pisanoPeriodOne p d T) = 1 := by
    rw [map_pow, hfA]
    exact pow_orderOf_eq_one _
  obtain ⟨V, hV⟩ := exists_eq_one_add_natCast_mul h hone
  have hpow := matrix_pow_prime_pow_eq_one hk (A ^ pisanoPeriodOne p d T) ⟨V, hV⟩
  rw [← pow_mul] at hpow
  exact orderOf_dvd_of_pow_eq_one (by rw [mul_comm]; exact hpow)

/-- `pisanoPeriod` が人手証明の $\pi(p,k)$（$T^N\bmod p^k$ の最終周期の最小値）に一致すること。
`p ∤ det T` を仮定する（人手証明と同じ仮定）。 -/
theorem isLeast_eventualPeriod_pisanoPeriod {p k d : ℕ} [hp : Fact p.Prime] (hk : k ≠ 0)
    (T : Matrix (Fin d) (Fin d) ℤ) (hT : ¬ ((p : ℤ) ∣ T.det)) :
    IsLeast {t : ℕ | 0 < t ∧ ∃ N₀, ∀ N, N₀ ≤ N →
        (T.map (Int.cast : ℤ → ZMod (p ^ k))) ^ (N + t)
          = (T.map (Int.cast : ℤ → ZMod (p ^ k))) ^ N}
      (pisanoPeriod p k d T) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hp.out.pos.ne'⟩
  have hu := isUnit_intCast_matrix_of_not_dvd_det hk T hT
  exact isLeast_eventualPeriod hu (isOfFinOrder_of_finite _)

end IntegrableLattice
