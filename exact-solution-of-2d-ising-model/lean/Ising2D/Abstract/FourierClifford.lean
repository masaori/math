/-
# 抽象版: Clifford 族の「フーリエ和」どうしの反交換子

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `anticommutator_of_hat_Z_and_hat_Y` | `Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean` |
| （使う 2 つの材料）`anticommutator_of_Z_and_Y`, `exp_sum` | `Ising2D/Part006/...`, `Ising2D/Part004/Claim008_ExpSum.lean` |

具体版を本ファイルの抽象版の特殊化として導出したものは
`Ising2D/Part007/Claim000_AnticommutatorHatZHatYAbstract.lean` にある。

## 抽象版が何を明らかにするか

原文の 4 本の反交換関係
`[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I` などに効いているのは、次の 2 つだけ。

1. **元の族が Clifford 関係を満たすこと** `[x_a, y_b]₊ = 2 δ_{ab} · 1`。
2. **位相因子が 1 の原始 `M` 乗根のべきであること**（直交性 `sum_zpow_primitiveRoot`）。

さらに `(±)` の重み（原文の `∓1`、`Ising2D.firstSign`）については、
**両側の重みの積 `u_j v_j` しか結論に現れない**。原文 1（複号同順）は `u_j v_j = 1`、
原文 2（複号逆）は「`j = 1` の項だけ `u_j v_j = -1`、他は `1`」の場合である。
すなわち原文の `η^2 = 1` という条件は、この積が `1` になるための十分条件にすぎない。

効いていないもの: 台が**行列**であること、**複素数**上であること、テンソル冪であること、
`Z, Y` の具体形（Jordan–Wigner 文字列）、指数関数・円周率の解析的性質。
-/
import Ising2D.Abstract.RootOfUnitySum
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators

namespace Ising2D.Abstract

/-! ## Clifford 族の線型結合どうしの反交換子（任意の可換環係数） -/

section Clifford

variable {S A : Type*} [CommRing S] [Ring A] [Algebra S A]

/-- **Clifford 関係で二重和が対角へ落ちる**（原文の「`δ` により `j = k` の項だけ残る」の行）。

`Ising2D.acomm_sum_smul_clifford` の係数環を ℂ から任意の可換環へ一般化した形。 -/
theorem acomm_sum_smul_clifford_abstract {ι : Type*} [Fintype ι] [DecidableEq ι]
    (c d : ι → S) (x y : ι → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : S) else 0) • (1 : A)) :
    acomm (∑ i, c i • x i) (∑ j, d j • y j) = (∑ i, c i * d i * 2) • (1 : A) := by
  classical
  rw [acomm_sum_smul, Finset.sum_smul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_eq_single_of_mem i (Finset.mem_univ i)]
  · rw [h, if_pos rfl, smul_smul]
  · intro j _ hji
    rw [h, if_neg (Ne.symm hji), zero_smul, smul_zero]

end Clifford

/-! ## フーリエ和どうしの反交換子 -/

section Fourier

variable {K A : Type*} [Field K] [Ring A] [Algebra K A]

/-- **一般の重みつきフーリエ和どうしの反交換子**。

`x, y` が Clifford 関係を満たすとき、位相因子 `ζ^{j μ}` と重み `u_j, v_j` をつけた和について

  `[∑_j u_j ζ^{jμ} x_j, ∑_j v_j ζ^{jν} y_j]₊ = (2 ∑_j u_j v_j ζ^{j(μ+ν)}) · 1`。

結論には**両側の重みの積 `u_j v_j` しか現れない**。 -/
theorem acomm_fourier_clifford_weights {M : ℕ} {ζ : K} (hζ0 : ζ ≠ 0)
    (x y : Fin M → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : K) else 0) • (1 : A))
    (u v : Fin M → K) (μ ν : ℤ) :
    acomm (∑ j : Fin M, (u j * ζ ^ ((((j : ℕ) : ℤ) + 1) * μ)) • x j)
        (∑ j : Fin M, (v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)) • y j)
      = (2 * ∑ j : Fin M, u j * v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν))) • (1 : A) := by
  rw [acomm_sum_smul_clifford_abstract _ _ _ _ h]
  congr 1
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  have hz : ζ ^ ((((j : ℕ) : ℤ) + 1) * μ) * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)
      = ζ ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν)) := by
    rw [← zpow_add₀ hζ0]
    congr 1
    ring
  calc u j * ζ ^ ((((j : ℕ) : ℤ) + 1) * μ) * (v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)) * 2
      = (u j * v j) * (ζ ^ ((((j : ℕ) : ℤ) + 1) * μ) * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)) * 2 := by
        ring
    _ = 2 * (u j * v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν))) := by rw [hz]; ring

/-- **原文 1・4 の抽象版**（重みの積が全サイトで `1` の場合）:

  `[∑_j u_j ζ^{jμ} x_j, ∑_j v_j ζ^{jν} y_j]₊ = 2M δ^M_{μ+ν,0} · 1`。

原文の `hat(Z)^{(±)}` どうし（複号同順）と `hat(Y)` どうしがこの場合にあたる。
必要なのは `u_j v_j = 1` と、`ζ` が 1 の原始 `M` 乗根であることだけ。 -/
theorem acomm_fourier_clifford {M : ℕ} (hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M)
    (x y : Fin M → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : K) else 0) • (1 : A))
    (u v : Fin M → K) (huv : ∀ j, u j * v j = 1) (μ ν : ℤ) :
    acomm (∑ j : Fin M, (u j * ζ ^ ((((j : ℕ) : ℤ) + 1) * μ)) • x j)
        (∑ j : Fin M, (v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)) • y j)
      = (2 * (M : K) * (if (M : ℤ) ∣ (μ + ν) then 1 else 0)) • (1 : A) := by
  rw [acomm_fourier_clifford_weights (hζ.ne_zero hM) x y h u v μ ν]
  congr 1
  rw [Finset.sum_congr rfl fun j _ => by rw [huv j, one_mul], sum_zpow_primitiveRoot hM hζ]
  ring

/-- **原文 2 の抽象版**（`j = 1` の項だけ重みの積が `-1` の場合）:

  `[…]₊ = (2M δ^M_{μ+ν,0} - 4 ζ^{μ+ν}) · 1`。

原文の `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊` がこの場合にあたる。原文の説明
「`j = 1` の項の符号だけが反転するので、その項を 2 回引く」がそのまま計算になっている。 -/
theorem acomm_fourier_clifford_flip {M : ℕ} (hM : M ≠ 0) {ζ : K} (hζ : IsPrimitiveRoot ζ M)
    (x y : Fin M → A)
    (h : ∀ a b, acomm (x a) (y b) = (if a = b then (2 : K) else 0) • (1 : A))
    (u v : Fin M → K)
    (hflip : ∀ j : Fin M, u j * v j = if (j : ℕ) = 0 then -1 else 1) (μ ν : ℤ) :
    acomm (∑ j : Fin M, (u j * ζ ^ ((((j : ℕ) : ℤ) + 1) * μ)) • x j)
        (∑ j : Fin M, (v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * ν)) • y j)
      = (2 * (M : K) * (if (M : ℤ) ∣ (μ + ν) then 1 else 0)
          - 4 * ζ ^ (μ + ν)) • (1 : A) := by
  classical
  set z : Fin M := ⟨0, Nat.pos_of_ne_zero hM⟩ with hz
  have hzval : (z : ℕ) = 0 := rfl
  rw [acomm_fourier_clifford_weights (hζ.ne_zero hM) x y h u v μ ν]
  congr 1
  have hterm : ∀ j : Fin M,
      u j * v j * ζ ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν))
        = ζ ^ ((((j : ℕ) : ℤ) + 1) * (μ + ν))
          + (if (j : ℕ) = 0 then -(2 * ζ ^ (μ + ν)) else 0) := by
    intro j
    by_cases hj : (j : ℕ) = 0
    · have hexp : (((j : ℕ) : ℤ) + 1) * (μ + ν) = μ + ν := by rw [hj]; push_cast; ring
      rw [hflip j, if_pos hj, if_pos hj, hexp]
      ring
    · rw [hflip j, if_neg hj, if_neg hj, one_mul, add_zero]
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib,
    sum_zpow_primitiveRoot hM hζ]
  have hsingle : ∑ j : Fin M, (if (j : ℕ) = 0 then -(2 * ζ ^ (μ + ν)) else 0)
      = -(2 * ζ ^ (μ + ν)) := by
    rw [Finset.sum_eq_single_of_mem z (Finset.mem_univ z)]
    · rw [if_pos hzval]
    · intro j _ hj
      rw [if_neg (fun hv => hj (Fin.val_injective (by rw [hv, hzval])))]
  rw [hsingle]
  ring

end Fourier

end Ising2D.Abstract
