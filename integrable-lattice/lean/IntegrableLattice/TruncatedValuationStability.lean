/-
# 命題 U の (U6) の残り半分（切り捨て付値列が $\tilde E\bmod\ell^{N}$ で決まる側）— cycle 42 step 4

対応する人手証明: 本文ブロック `paper_112_theorem_coefficient_layers`（命題 U）の (U6 逆向き)
（「$\tilde E'=\tilde E+\ell^{N}h$ と置くと $\Phi^{[k]}$ は係数の $\mathcal{O}_k$ 係数線形式なので
$A'^{[k]}_m=A^{[k]}_m+\ell^{N}\beta_m$ となり、切り捨て付きの付値列
$\bigl(\min(v_\ell(A^{[k]}_m),N)\bigr)_m$ が $\tilde E\bmod\ell^{N}$ で決まる」）。

## この step が埋めるもの（cycle 41 step 2 の測定を受けて）

cycle 41 step 2 は、散文が「形式化した」と書いている部のうち閉じた宣言を名指せないもの 7 件を解き、
**残り 6 件は「在る宣言が部より狭かった」形である**と測った。
その 6 件のうち (U6) は **「半分だけ書いてある」**形で、
`Cycle25Corrections.U6_trunc_determines_stage_data` が与えるのは
**「切り捨て付値列 $\Rightarrow$ 段データ」の側だけ**である。
`Cycle25Corrections.lean` 自身が、残る側（$A'_m=A_m+\ell^{N}\beta_m$ の側）を
未形式化として書いている。

cycle 42 の焦点 3 は「**広げる先が本文のどこまでかを測ることから始める**」だった。
測った結果、残る側はさらに 2 つに割れる。

1. **切り捨て付値の安定性**——$A'=A+\ell^{N}\beta$ なら $\min(v_\ell(A'),N)=\min(v_\ell(A),N)$。
2. **$\Phi^{[k]}$ が $\mathcal{O}_k$ 係数の線形式であることの配線**——
   $\tilde E'=\tilde E+\ell^{N}h$ から $A'_m=A_m+\ell^{N}\beta_m$ を出す段。

**本ファイルが書いたのは 1 である。2 は残る。そう書く。**
1 は本文が「切り捨て付きの付値列が $\tilde E\bmod\ell^{N}$ で決まる」と言うときの中身そのものであり、
2 は本論文の $\Phi^{[k]}$ の定義に沿った配線である。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。付値は $\mathbb{N}\cup\{\infty\}$ に値をとり、
使うのは整除の判定と $\mathbb{N}\cup\{\infty\}$ の順序だけである。

## 書いたこと（3 段）

1. **$\ell^{N}$ の倍数の付値は $N$ 以上である**（`le_emultiplicity_of_pow_dvd`）。
2. **切り捨て付値の安定性**（`min_emultiplicity_add_eq`）。
   場合分けは 2 つだけである——$v(A)<N$ なら $v(\ell^{N}\beta)>v(A)$ なので
   和の付値は $v(A)$ に等しく（`emultiplicity_add_of_gt`）、
   $v(A)\ge N$ なら和の付値も $N$ 以上である（`min_le_emultiplicity_add`）。
   どちらの場合も $N$ で切り捨てると一致する。
3. **列の形**（`min_emultiplicity_add_eq_seq`）。本文の $(A_m)_m$ に当たる。

## 形式化しなかったもの

* **$\Phi^{[k]}$ が $\mathcal{O}_k$ 係数の線形式であることの配線。**
  本文が $\tilde E'=\tilde E+\ell^{N}h$ から $A'_m=A_m+\ell^{N}\beta_m$ を出す段である。
  これは mathlib の欠落ではなく、本論文の $\Phi^{[k]}$ の定義を Lean へ持ち込む配線である。
  **持ち込んでいないので書いていない。そう書く。**
-/
import Mathlib
import IntegrableLattice.Cycle25Corrections

namespace IntegrableLattice
namespace TruncatedValuation

open scoped Classical

variable {α : Type*} [CommRing α]

/-- $\ell^{N}$ で割り切れる元の付値は $N$ 以上である。 -/
theorem le_emultiplicity_of_pow_dvd {ℓ a : α} {N : ℕ} (h : ℓ ^ N ∣ a) :
    (N : ℕ∞) ≤ emultiplicity ℓ a :=
  pow_dvd_iff_le_emultiplicity.mp h

/-- **切り捨て付値の安定性**（本文 (U6 逆向き) の中身）。

$A'=A+\ell^{N}\beta$ なら、$N$ で切り捨てた付値は $A$ と $A'$ で一致する。
すなわち**切り捨て付値列は $\ell^{N}$ を法とした情報だけで決まる。** -/
theorem min_emultiplicity_add_eq {ℓ a b : α} {N : ℕ} (hb : ℓ ^ N ∣ b) :
    min (emultiplicity ℓ (a + b)) (N : ℕ∞) = min (emultiplicity ℓ a) (N : ℕ∞) := by
  have hbN : (N : ℕ∞) ≤ emultiplicity ℓ b := le_emultiplicity_of_pow_dvd hb
  by_cases ha : emultiplicity ℓ a < (N : ℕ∞)
  · -- $v(a)<N\le v(b)$ なので和の付値は $v(a)$ に等しい
    have hgt : emultiplicity ℓ a < emultiplicity ℓ b := lt_of_lt_of_le ha hbN
    have := emultiplicity_add_of_gt (p := ℓ) (a := b) (b := a) hgt
    rw [add_comm, this]
  · -- $v(a)\ge N$ なら和の付値も $N$ 以上である
    push_neg at ha
    have hsum : (N : ℕ∞) ≤ emultiplicity ℓ (a + b) :=
      le_trans (le_min ha hbN) min_le_emultiplicity_add
    rw [min_eq_right hsum, min_eq_right ha]

/-- **列の形**。本文の $(A^{[k]}_m)_m$ と $(A'^{[k]}_m)_m$ に当たる。 -/
theorem min_emultiplicity_add_eq_seq {ι : Type*} {ℓ : α} {A β : ι → α} {N : ℕ}
    (hβ : ∀ m, ℓ ^ N ∣ β m) (m : ι) :
    min (emultiplicity ℓ (A m + β m)) (N : ℕ∞) = min (emultiplicity ℓ (A m)) (N : ℕ∞) :=
  min_emultiplicity_add_eq (hβ m)

end TruncatedValuation
end IntegrableLattice
