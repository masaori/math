/-
# 巡回群による指標分解（voltage ラプラシアンを塔の各層へ分ける段）— cycle 38 step 2

対応する人手証明:

* 本文ブロック `paper_def_graph_tower`（voltage グラフ・導来グラフ・voltage ラプラシアン）
* 本文ブロック `paper_prop_T`（命題 T）の証明が引く「指標による対角化」
  （本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引く）

## このファイルが埋めるもの

cycle 37 step 2 で Kirchhoff の matrix-tree 定理が完了したので、それを共有していた本文の
主張 5 件（命題 G・命題 G′・命題 G″・命題 T・命題 M）の残りは **指標分解** になった。
本ファイルはその芯を書く。

芯は 1 行で言える——**巡回群の作用で不変な行列は、指標の行列で共役をとると
ブロック対角になる。** 導来グラフのラプラシアンは、頂点集合が $V\times\Gamma$ で、
辺が $\Gamma$ の平行移動で写り合うので、この形をしている。ブロック対角の行列式は
ブロックの行列式の積なので、そこから

$$\det L(X_{N}) = \prod_{j\in\mathbb{Z}/N} \det \widehat L(j)$$

が出る。$\widehat L(j)$ が voltage ラプラシアンの $z=\zeta^{j}$ での評価値である、というのが
本文の言う「指標による対角化」である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**この file は $\mathbb{R}$ へ 1 度も出ない。** 係数環 $R$ は「$1$ の原始 $N$ 乗根 $\zeta$ を含む
整域で、$N$ が単元であるもの」とだけ仮定する。本論文が当てるのは
$\mathbb{Z}[\zeta_N]\subset\overline{\mathbb{Q}}$ であり、これは可算である。
$\mathbb{C}$ を経由する必要はない。

## 書いたこと（3 段）

1. **指標の直交性**（`sum_pow_mul`）。$\sum_{g\in\mathbb{Z}/N}\zeta^{\,g\,d}$ は
   $N\mid d$ のとき $N$、それ以外のとき $0$ である。等比の和と、$\zeta$ が原始根であることだけで出る。
2. **指標の行列が可逆であること**（`fourier_mul_inv`）。
3. **ブロック巡回行列のブロック対角化と行列式**（`det_eq_prod_det_hat`）。

## 形式化しなかったもの

このファイルが書いたのは巡回群 1 つの場合だけである。
cycle 38 の時点で残していた 3 つ（2 つの巡回群の積の場合、導来グラフのラプラシアンが
ブロック巡回であることの当てはめ、各層のブロックが voltage ラプラシアンの $z=\zeta^{j}$ での
評価値であること）は、**cycle 39 step 2 で `CharacterDecompositionTwoVariable.lean` に書いた。**

そちらにも残りがある。

* **一般の有限アーベル群 $\Gamma$** は扱っていない。書いたのは巡回群 1 つと、
  巡回群 2 つの積までである。本文が要るのは後者なので当面は足りるが、一般の $\Gamma$ ではない。
* **基礎グラフを型として持っていない。** 導来グラフの側は voltage ごとの辺の本数
  $a_{uv}(d)$ という核の形で受け取っており、それが基礎グラフの辺から定まることは書いていない。
-/
import Mathlib

namespace IntegrableLattice
namespace CharacterDecomposition

open Finset Matrix

variable {R : Type*} [CommRing R] [IsDomain R]
variable {N : ℕ} [NeZero N] {ζ : R}

/-! ## 1. 指標の直交性

$\zeta$ は $1$ の原始 $N$ 乗根とする。$\sum_{g\in\mathbb{Z}/N}(\zeta^{d})^{g}$ は、
$\zeta^{d}=1$（＝ $N\mid d$）なら項が全部 $1$ なので $N$、そうでなければ等比の和で $0$ になる。
$0$ になる側に要るのは整域であることだけで、$\zeta^{d}$ が原始根であることは要らない。 -/

section Orthogonality

/-- $\eta^N=1$ かつ $\eta\neq1$ なら $\sum_{r<N}\eta^{r}=0$。等比の和と整域性だけで出る。 -/
theorem geom_sum_eq_zero_of_pow_eq_one {η : R} (hpow : η ^ N = 1) (hne : η ≠ 1) :
    ∑ r ∈ range N, η ^ r = 0 := by
  have hmul : (∑ r ∈ range N, η ^ r) * (η - 1) = 0 := by
    rw [geom_sum_mul, hpow, sub_self]
  rcases mul_eq_zero.mp hmul with h | h
  · exact h
  · exact absurd (sub_eq_zero.mp h) hne

/-- $\mathbb{Z}/N$ 上の和を $0,\dots,N-1$ の和へ書き換える（`ZMod.val` は全単射）。 -/
theorem sum_zmod_eq_sum_range (f : ℕ → R) :
    ∑ g : ZMod N, f g.val = ∑ r ∈ range N, f r := by
  classical
  refine Finset.sum_nbij' (fun g => g.val) (fun r => (r : ZMod N)) ?_ ?_ ?_ ?_ ?_
  · intro g _; exact mem_range.mpr (ZMod.val_lt g)
  · intro r _; exact mem_univ _
  · intro g _; simpa using (ZMod.natCast_val (n := N) g).symm.trans (ZMod.cast_id N g)
  · intro r hr; exact ZMod.val_cast_of_lt (mem_range.mp hr)
  · intro g _; rfl

/-- **指標の直交性。** $\sum_{g\in\mathbb{Z}/N}\zeta^{\,g\,d}$ は $N\mid d$ なら $N$、それ以外は $0$。 -/
theorem sum_pow_mul (hζ : IsPrimitiveRoot ζ N) (d : ℕ) :
    ∑ g : ZMod N, ζ ^ (g.val * d) = if N ∣ d then (N : R) else 0 := by
  have hrw : ∀ g : ZMod N, ζ ^ (g.val * d) = (ζ ^ d) ^ g.val := by
    intro g; rw [← pow_mul, mul_comm]
  rw [Finset.sum_congr rfl fun g _ => hrw g,
    sum_zmod_eq_sum_range (N := N) (fun r => (ζ ^ d) ^ r)]
  by_cases h : N ∣ d
  · -- $\zeta^{d}=1$ なので項が全部 $1$。
    have h1 : ζ ^ d = 1 := (hζ.pow_eq_one_iff_dvd d).mpr h
    simp [h1, h]
  · -- $\zeta^{d}\neq1$ なので等比の和が $0$。
    have h1 : ζ ^ d ≠ 1 := fun hc => h ((hζ.pow_eq_one_iff_dvd d).mp hc)
    have hpow : (ζ ^ d) ^ N = 1 := by
      rw [← pow_mul, mul_comm, pow_mul, hζ.pow_eq_one, one_pow]
    rw [geom_sum_eq_zero_of_pow_eq_one hpow h1, if_neg h]

end Orthogonality

/-! ## 2. 指標の行列とその逆

$V$ を有限型（本論文では voltage グラフの頂点集合）とし、
$P_{(u,g),(v,j)}=\delta_{uv}\,\zeta^{\,g\,j}$、$Q_{(u,j),(v,g)}=\delta_{uv}\,N^{-1}\zeta^{-g\,j}$ と置く。
$\zeta^{-1}$ を使わずに済むよう、$\zeta^{-gj}$ は $\zeta^{\,g\,(N-j)}$ の形で書く。 -/

section Fourier

variable {V : Type*} [Fintype V] [DecidableEq V]

/-- $\zeta$ の逆元（$\zeta^{N-1}$）。$\zeta^{N}=1$ なので $\zeta\cdot\zeta^{N-1}=1$ である。 -/
noncomputable def zetaInv (ζ : R) (N : ℕ) : R := ζ ^ (N - 1)

omit [IsDomain R] in
theorem zeta_mul_zetaInv (hζ : IsPrimitiveRoot ζ N) : ζ * zetaInv ζ N = 1 := by
  have hN : 1 ≤ N := Nat.one_le_iff_ne_zero.mpr (NeZero.ne N)
  rw [zetaInv, ← pow_succ', Nat.sub_add_cancel hN, hζ.pow_eq_one]

/-- 指標の行列 $P_{(u,g),(v,j)}=\delta_{uv}\,\zeta^{\,g\,j}$。 -/
noncomputable def fourier (ζ : R) (V : Type*) [DecidableEq V] (N : ℕ) :
    Matrix (V × ZMod N) (V × ZMod N) R :=
  Matrix.of fun p q => if p.1 = q.1 then ζ ^ (p.2.val * q.2.val) else 0

/-- 逆側の行列 $Q_{(u,j),(v,g)}=\delta_{uv}\,N^{-1}\,\zeta^{-g\,j}$。 -/
noncomputable def fourierInv (ζ : R) (V : Type*) [DecidableEq V] (N : ℕ) (c : R) :
    Matrix (V × ZMod N) (V × ZMod N) R :=
  Matrix.of fun p q => if p.1 = q.1 then c * (zetaInv ζ N) ^ (p.2.val * q.2.val) else 0


omit [IsDomain R] [NeZero N] in
/-- $\zeta^{N}=1$ なら指数は $\bmod N$ でよい。 -/
theorem pow_mod (hζ : ζ ^ N = 1) (k : ℕ) : ζ ^ (k % N) = ζ ^ k := by
  conv_rhs => rw [← Nat.div_add_mod k N]
  rw [pow_add, pow_mul, hζ, one_pow, one_mul]

omit [IsDomain R] in
/-- $\mathbb{Z}/N$ の加法が指数の積へ移ること。 -/
theorem pow_val_add (hζ : ζ ^ N = 1) (g d : ZMod N) :
    ζ ^ ((g + d).val) = ζ ^ g.val * ζ ^ d.val := by
  rw [ZMod.val_add, pow_mod hζ, pow_add]

end Fourier

/-! ## 3. ブロック巡回行列のブロック対角化と行列式

$M_{(u,g),(v,h)}=c_{uv}(h-g)$（$\mathbb{Z}/N$ の平行移動で不変）を**ブロック巡回**と呼ぶ。
導来グラフのラプラシアンはこの形をしている（辺が $\Gamma$ の平行移動で写り合うため）。

$\widehat M(j)_{uv}:=\sum_{d}c_{uv}(d)\,\zeta^{\,d\,j}$ と置くと $Q\,M\,P$ が
$\widehat M$ のブロック対角になり、$\det M=\prod_j\det\widehat M(j)$ が出る。 -/

section BlockCirculant

variable {V : Type*} [Fintype V] [DecidableEq V]

/-- ブロック巡回行列。$M_{(u,g),(v,h)}=c_{uv}(h-g)$。 -/
def blockCirculant (c : V → V → ZMod N → R) : Matrix (V × ZMod N) (V × ZMod N) R :=
  Matrix.of fun p q => c p.1 q.1 (q.2 - p.2)

/-- 指標で変換した各層のブロック $\widehat M(j)_{uv}=\sum_d c_{uv}(d)\zeta^{\,d\,j}$。 -/
noncomputable def hat (ζ : R) (c : V → V → ZMod N → R) (j : ZMod N) : Matrix V V R :=
  Matrix.of fun u v => ∑ d : ZMod N, c u v d * ζ ^ (d.val * j.val)

omit [IsDomain R] in
/-- $M\,P$ の成分。行 $(u,g)$・列 $(v,j)$ の成分は
$\zeta^{\,g\,j}\,\widehat M(j)_{uv}$ である（本文の「指標で対角化する」の中身）。 -/
theorem blockCirculant_mul_fourier (hζ : ζ ^ N = 1) (c : V → V → ZMod N → R)
    (u v : V) (g j : ZMod N) :
    (blockCirculant (N := N) c * fourier ζ V N) (u, g) (v, j)
      = ζ ^ (g.val * j.val) * hat ζ c j u v := by
  classical
  rw [Matrix.mul_apply, ← Finset.univ_product_univ, Finset.sum_product]
  have hinner : ∀ w ∈ (Finset.univ : Finset V),
      ∑ h : ZMod N, blockCirculant (N := N) c (u, g) (w, h) * fourier ζ V N (w, h) (v, j)
        = if w = v then ∑ h : ZMod N, c u v (h - g) * ζ ^ (h.val * j.val) else 0 := by
    intro w _
    by_cases hw : w = v
    · subst hw; simp [blockCirculant, fourier]
    · simp [fourier, hw]
  rw [Finset.sum_congr rfl hinner, Finset.sum_ite_eq' Finset.univ v, if_pos (Finset.mem_univ v)]
  rw [← Fintype.sum_equiv (Equiv.addLeft g)
    (fun d => c u v ((g + d) - g) * ζ ^ ((g + d).val * j.val))
    (fun h => c u v (h - g) * ζ ^ (h.val * j.val)) (fun d => rfl)]
  simp only [hat, Matrix.of_apply, Finset.mul_sum]
  refine Finset.sum_congr rfl fun d _ => ?_
  simp only [Matrix.of_apply, add_sub_cancel_left]
  rw [pow_mul, pow_val_add hζ, mul_pow, ← pow_mul, ← pow_mul]
  ring

omit [IsDomain R] in
/-- $Q\,(M\,P)$ の成分。$\sum_{g}\zeta^{\,g(j-k)}$ が現れる形へ整理する。 -/
theorem fourierInv_mul_blockCirculant_mul_fourier (hζ : ζ ^ N = 1) (cinv : R)
    (c : V → V → ZMod N → R) (u v : V) (k j : ZMod N) :
    (fourierInv ζ V N cinv * (blockCirculant (N := N) c * fourier ζ V N)) (u, k) (v, j)
      = cinv * (∑ g : ZMod N, ζ ^ (g.val * (k.val * (N - 1) + j.val)))
          * hat ζ c j u v := by
  classical
  rw [Matrix.mul_apply, ← Finset.univ_product_univ, Finset.sum_product]
  have hinner : ∀ w ∈ (Finset.univ : Finset V),
      ∑ g : ZMod N, fourierInv ζ V N cinv (u, k) (w, g)
          * (blockCirculant (N := N) c * fourier ζ V N) (w, g) (v, j)
        = if w = u then
            ∑ g : ZMod N, cinv * (zetaInv ζ N) ^ (k.val * g.val)
              * (ζ ^ (g.val * j.val) * hat ζ c j u v)
          else 0 := by
    intro w _
    by_cases hw : w = u
    · subst hw
      rw [if_pos rfl]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [blockCirculant_mul_fourier hζ]
      simp [fourierInv]
    · simp only [fourierInv, Matrix.of_apply, if_neg (Ne.symm hw), zero_mul,
        Finset.sum_const_zero, if_neg hw]
  rw [Finset.sum_congr rfl hinner, Finset.sum_ite_eq' Finset.univ u, if_pos (Finset.mem_univ u)]
  rw [Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun g _ => ?_
  -- $(\zeta^{N-1})^{k g}\,\zeta^{g j}=\zeta^{\,g\,(k(N-1)+j)}$。
  rw [zetaInv, ← pow_mul]
  have hexp : g.val * (k.val * (N - 1) + j.val) = (N - 1) * (k.val * g.val) + g.val * j.val := by
    ring
  rw [hexp, pow_add]
  ring

omit [IsDomain R] in
/-- $N\mid k(N-1)+j$ であることは $j=k$ と同値である
（$k(N-1)\equiv-k\pmod N$ なので、割り切れることは $j\equiv k$ に他ならない）。 -/
theorem dvd_iff_eq (k j : ZMod N) : N ∣ (k.val * (N - 1) + j.val) ↔ j = k := by
  have hN : 1 ≤ N := Nat.one_le_iff_ne_zero.mpr (NeZero.ne N)
  -- $(N-1:\mathbb{N})$ の $\mathbb{Z}/N$ での像は $-1$ である。
  have hcast : ((N - 1 : ℕ) : ZMod N) = -1 := by
    have h0 : ((N - 1 : ℕ) : ZMod N) + ((1 : ℕ) : ZMod N) = ((N : ℕ) : ZMod N) := by
      rw [← Nat.cast_add, Nat.sub_add_cancel hN]
    rw [ZMod.natCast_self, Nat.cast_one] at h0
    linear_combination h0
  rw [← ZMod.natCast_eq_zero_iff]
  push_cast [hcast]
  rw [ZMod.natCast_val, ZMod.natCast_val, ZMod.cast_id, ZMod.cast_id]
  constructor
  · intro h; linear_combination h
  · rintro rfl; ring

/-- **$Q\,M\,P$ はブロック対角である。** これが「指標による対角化」そのものである。 -/
theorem fourierInv_mul_mul_fourier (hζ : IsPrimitiveRoot ζ N) {cinv : R}
    (hcinv : cinv * (N : R) = 1) (c : V → V → ZMod N → R) :
    fourierInv ζ V N cinv * (blockCirculant (N := N) c * fourier ζ V N)
      = Matrix.blockDiagonal (hat ζ c) := by
  classical
  ext p q
  obtain ⟨u, k⟩ := p
  obtain ⟨v, j⟩ := q
  rw [fourierInv_mul_blockCirculant_mul_fourier hζ.pow_eq_one, sum_pow_mul hζ,
    Matrix.blockDiagonal_apply]
  by_cases h : j = k
  · subst h
    rw [if_pos ((dvd_iff_eq (N := N) j j).mpr rfl), if_pos rfl, hcinv, one_mul]
  · rw [if_neg (fun hc => h ((dvd_iff_eq (N := N) k j).mp hc)), if_neg (Ne.symm h),
      mul_zero, zero_mul]

omit [IsDomain R] in
/-- 単位行列はブロック巡回である（核は $u=v$ かつ $d=0$ のときだけ $1$）。 -/
theorem one_eq_blockCirculant :
    (1 : Matrix (V × ZMod N) (V × ZMod N) R)
      = blockCirculant (N := N) (fun u v d => if u = v ∧ d = 0 then 1 else 0) := by
  classical
  ext p q
  obtain ⟨u, g⟩ := p
  obtain ⟨v, h⟩ := q
  by_cases huv : u = v
  · subst huv
    by_cases hgh : g = h
    · subst hgh; simp [blockCirculant, Matrix.one_apply]
    · simp [blockCirculant, Matrix.one_apply, Prod.ext_iff, hgh, sub_eq_zero, Ne.symm hgh]
  · simp [blockCirculant, Matrix.one_apply, Prod.ext_iff, huv]

omit [IsDomain R] in
/-- 単位行列の各層のブロックは単位行列である。 -/
theorem hat_one (j : ZMod N) :
    hat ζ (V := V) (fun u v (d : ZMod N) => if u = v ∧ d = 0 then 1 else 0) j
      = (1 : Matrix V V R) := by
  classical
  ext u v
  rw [hat]
  simp only [Matrix.of_apply]
  by_cases huv : u = v
  · subst huv
    simp only [true_and, Matrix.one_apply_eq]
    rw [Finset.sum_congr rfl (fun d (_ : d ∈ (Finset.univ : Finset (ZMod N))) =>
      show (if d = 0 then (1 : R) else 0) * ζ ^ (d.val * j.val)
        = if d = 0 then (1 : R) else 0 by
        by_cases hd : d = 0
        · subst hd; simp
        · simp [hd])]
    simp
  · simp [huv, Matrix.one_apply_ne huv]

/-- $Q$ と $P$ の行列式の積は $1$ である（上の等式で $M=1$ と置く）。 -/
theorem det_fourierInv_mul_det_fourier (hζ : IsPrimitiveRoot ζ N) {cinv : R}
    (hcinv : cinv * (N : R) = 1) :
    (fourierInv ζ V N cinv).det * (fourier ζ V N).det = 1 := by
  classical
  have h := fourierInv_mul_mul_fourier (V := V) hζ hcinv
    (fun u v (d : ZMod N) => if u = v ∧ d = 0 then 1 else 0)
  rw [← one_eq_blockCirculant (R := R) (N := N) (V := V),
    funext (hat_one (ζ := ζ) (V := V) (N := N)), one_mul] at h
  rw [show Matrix.blockDiagonal (fun _ : ZMod N => (1 : Matrix V V R)) = 1 from
    Matrix.blockDiagonal_one] at h
  have h2 := congrArg Matrix.det h
  rwa [Matrix.det_mul, Matrix.det_one] at h2

/-- **指標分解。** ブロック巡回行列の行列式は、各層のブロックの行列式の積である。

$$\det M=\prod_{j\in\mathbb{Z}/N}\det\widehat M(j).$$

本文が 命題 T ほかの証明で「指標による対角化」と呼んでいる段の中身である。
係数環は「$1$ の原始 $N$ 乗根 $\zeta$ を持ち $N$ が単元である整域」だけを仮定するので、
$\mathbb{Z}[\zeta_N]\subset\overline{\mathbb{Q}}$ で足りる。$\mathbb{R}$ にも $\mathbb{C}$ にも出ない。 -/
theorem det_blockCirculant (hζ : IsPrimitiveRoot ζ N) {cinv : R} (hcinv : cinv * (N : R) = 1)
    (c : V → V → ZMod N → R) :
    (blockCirculant (N := N) c).det = ∏ j : ZMod N, (hat ζ c j).det := by
  classical
  have h := congrArg Matrix.det (fourierInv_mul_mul_fourier (V := V) hζ hcinv c)
  rw [Matrix.det_mul, Matrix.det_mul, Matrix.det_blockDiagonal] at h
  have hdet1 := det_fourierInv_mul_det_fourier (V := V) hζ hcinv
  calc (blockCirculant (N := N) c).det
      = ((fourierInv ζ V N cinv).det * (fourier ζ V N).det)
          * (blockCirculant (N := N) c).det := by rw [hdet1, one_mul]
    _ = (fourierInv ζ V N cinv).det
          * ((blockCirculant (N := N) c).det * (fourier ζ V N).det) := by ring
    _ = ∏ j : ZMod N, (hat ζ c j).det := h

end BlockCirculant

end CharacterDecomposition
end IntegrableLattice
