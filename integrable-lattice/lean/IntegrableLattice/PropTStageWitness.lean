/-
# 命題 T の舞台が空でないことの確認と、完備化の同定に何が要るかの実測

対応する人手証明: 本文ブロック `paper_062_theorem_T`（命題 T）の証明の段 3。

## この段で測ったこと

台帳の残り 1 項目は「本文の $\mathbb{Q}(\zeta_L)$ の 2 の上での完備化が
`PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo` の舞台の形をしていること
（$\zeta_L$ を含み、剰余体の標数が 2 であること）の同定」である。

**2026-08-05 に、この作業ツリーへ取り込んだ mathlib（`v4.32.1`）を直読して測った。**

| 要るもの | mathlib | 結果 |
|---|---|---|
| 完備化そのもの | `IsDedekindDomain.HeightOneSpectrum.adicCompletion` | 在る |
| その整数環 | `adicCompletionIntegers` | 在る（`ValuationSubring`） |
| それが離散付値環であること | `NumberField.Completion.FinitePlace` の `instance` | 在る |
| **それが $\mathfrak m$ 進完備であること** | `IsAdicComplete 𝓂 𝒪` | **無い** |
| 完備なら Hensel 的であること | `IsAdicComplete.henselianRing` | 在る |
| 局所体という舞台 | `IsNonarchimedeanLocalField` | クラスは在るが、**定義ファイルの外にインスタンスが 1 つも無い** |

すなわち **Hensel 性へ渡る鎖の途中の 1 本（完備化の整数環が $\mathfrak m$ 進完備であること）だけが
無く、そこは配線ではなく素材である。** mathlib が局所体について同じ事実を証明している箇所
（`Mathlib/NumberTheory/LocalField/Basic.lean`）はコンパクト性を経由しており、
数体の完備化がその舞台に載ることは述べられていない。

## 代わりに書いたこと（舞台が空でないこと）

舞台の仮定を満たす環が実在しなければ、段 3 の結論は空虚に真でありうる。
**そこで仮定を全部満たす具体的な環を 1 つ与える**（cycle 27 の
`nestedRes_rat_two_three` と同じ規律である）。

取ったのは **4 元体 $\mathbb{F}_4$**（`GaloisField 2 2`）で、$L=3$ である。
体は Hensel 的（`Field.henselian`）、剰余体は自分自身なので標数 2、
単元群は位数 3 の巡回群なのでその生成元が原始 3 乗根である。

**これは退化した舞台である**（極大イデアルが $0$ なので、
段 3 の合同「$r\equiv\zeta^{j}$」は等号になる）。**そう書く。**
本文が当てているのは混標数の舞台であり、それは上の表の 1 行が埋まるまで書けない。
ここで確かめたのは「仮定が矛盾していないこと」だけである。

$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも出ない。有限体と有限群の位数だけを使う。
-/
import Mathlib
import IntegrableLattice.PropTResidueRoot

namespace IntegrableLattice
namespace PropTStageWitness

open IsLocalRing

/-! ## 1. 体は舞台の仮定を満たす -/

/-- 体の剰余体は自分自身と同じ標数をもつ（剰余写像は体のあいだの環準同型なので単射）。 -/
instance charP_residueField_of_field (K : Type*) [Field K] (p : ℕ) [CharP K p] :
    CharP (ResidueField K) p :=
  charP_of_injective_ringHom (residue K).injective p

/-! ## 2. 有限体の単元群の生成元は原始根である -/

/-- 位数 $n$ の元は原始 $n$ 乗根である（単位群の中で）。 -/
theorem isPrimitiveRoot_of_orderOf_eq {M : Type*} [CommMonoid M] (u : Mˣ) {n : ℕ}
    (hn : orderOf u = n) : IsPrimitiveRoot ((u : M)) n := by
  subst hn
  have h := IsPrimitiveRoot.orderOf u
  exact h.map_of_injective (f := (Units.coeHom M)) Units.val_injective

/-! ## 3. 4 元体を舞台として当てる -/

/-- $\mathbb{F}_4$ の単元群は位数 3 の巡回群なので、生成元は原始 3 乗根である。 -/
theorem exists_isPrimitiveRoot_three_galoisField :
    ∃ u : (GaloisField 2 2)ˣ, IsPrimitiveRoot ((u : GaloisField 2 2)) 3 := by
  classical
  haveI : Fintype (GaloisField 2 2) := Fintype.ofFinite (GaloisField 2 2)
  obtain ⟨g, hg⟩ := IsCyclic.exists_generator (α := (GaloisField 2 2)ˣ)
  have hcard : Nat.card (GaloisField 2 2)ˣ = 3 := by
    have hq : Nat.card (GaloisField 2 2) = 2 ^ 2 := GaloisField.card 2 2 (by norm_num)
    rw [Nat.card_eq_fintype_card, Fintype.card_units, ← Nat.card_eq_fintype_card, hq]
    norm_num

  refine ⟨g, isPrimitiveRoot_of_orderOf_eq g ?_⟩
  rw [orderOf_eq_card_of_forall_mem_zpowers hg, hcard]

/-- **舞台が空でないことの確認**。段 3 の仮定（Hensel 的な局所環・剰余体の標数 2・
原始 $L$ 乗根・$L$ 奇・$L\nmid j$）をすべて満たす具体例が実在する。

**退化した舞台である**（極大イデアルが $0$）。本文が当てている混標数の舞台は、
完備化の整数環が $\mathfrak m$ 進完備であることが mathlib に無いので、まだ当てられない。 -/
theorem stage_nonempty :
    ∃ (ζ : (GaloisField 2 2)ˣ) (L j : ℕ), Odd L ∧ IsPrimitiveRoot ((ζ : GaloisField 2 2)) L ∧
      ¬ L ∣ j := by
  obtain ⟨u, hu⟩ := exists_isPrimitiveRoot_three_galoisField
  exact ⟨u, 3, 1, ⟨1, by norm_num⟩, hu, by norm_num⟩

/-- **段 3 の結論が、その具体例の上で実際に使えること。**

`PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo` をそのまま当てている。 -/
theorem exists_root_on_galoisField (ζ : (GaloisField 2 2)ˣ)
    (hζ : IsPrimitiveRoot ((ζ : GaloisField 2 2)) 3) {j : ℕ} (hj : ¬ (3 : ℕ) ∣ j)
    (A : GaloisField 2 2)
    (hA : A - (((ζ ^ j : (GaloisField 2 2)ˣ) : GaloisField 2 2)
        + (((ζ ^ j)⁻¹ : (GaloisField 2 2)ˣ) : GaloisField 2 2)) ∈ maximalIdeal (GaloisField 2 2)) :
    ∃ r : GaloisField 2 2, r ^ 2 - A * r + 1 = 0 ∧
      r - ((ζ ^ j : (GaloisField 2 2)ˣ) : GaloisField 2 2) ∈ maximalIdeal (GaloisField 2 2) :=
  PropTResidueRoot.exists_root_congr_pow_of_odd_of_charTwo ζ ⟨1, by norm_num⟩ hζ hj A hA

end PropTStageWitness
end IntegrableLattice
