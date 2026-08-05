/-
# 命題 W\* の残り 3 件のうち「本文の整数行列 $G$ と代数側の Gram 行列の同定」— cycle 42 step 3

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の証明の第 2 段落
  （$\operatorname{Tr}T^N=\operatorname{Tr}_{A_\mathbb{Q}/\mathbb{Q}}(\mu\,\theta^N)$ の段）
* $G$ の定義は 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の statement
  （$G=(\operatorname{Tr}T^{i+j})\in M_r(\mathbb{Z})$）
* 本文が この等式の根拠として引いているのは、命題 C′ の証明の第 1 段落である——
  $S=\bigoplus_i C_{f_i}^{\oplus a_i}$ とおくと $\chi_S=\chi_T$ なので
  「Newton の公式より $\operatorname{Tr}S^N=\operatorname{Tr}T^N$」

## この step が測ったこと（掲げた焦点そのもの）

cycle 41 step 4 の走査は、Newton の関係が mathlib に**在る**ことを見つけた
（`MvPolynomial.psum` と `psum_eq_mul_esymm_sub_sum`）。
cycle 42 の焦点 1 は「**走査は在るまでしか言っておらず、当たるかは測っていない。まず当ててみること**」だった。

**当ててみた。当たらなかった。そう書く。**（2026-08-05 実測）

| 引いた先 | 実測 | なぜ当たらないか |
|---|---|---|
| `MvPolynomial.psum` / `psum_eq_mul_esymm_sub_sum` | 在る | **形式的な対称式の世界の恒等式である。**変数 $X_i$ についての `MvPolynomial σ R` の中で閉じており、行列の特性多項式の係数へ渡す宣言が無い |
| `Matrix.trace_pow` | **0 ファイル** | トレースの冪と特性多項式を結ぶ宣言そのものが無い |
| `Matrix.trace_eq_sum_roots_charpoly` | 在る | **$N=1$ だけ**である。しかも代数閉体（`IsAlgClosed`）を要求するので、$\mathbb{Q}$ 係数のまま使えない |

**在ることと当たることは別である**——cycle 41 step 4 が走査の限界として書いた 2 つのうちの片方が、
実測で確かめられた形になる。**当たらない理由は「無い」ではなく「橋が無い」である。**
Newton の関係そのものは在るが、それを行列のトレースへ渡すには
根を分解体で取り出す段が要り、そこは $\overline{\mathbb{Q}}$ への脱出を含む。

## 代わりに何を書いたか（橋の半分は架かる）

同定 $\operatorname{Tr}T^N=\operatorname{Tr}_{A}(\mu\,\theta^N)$ は 2 つに分かれる。

1. **代数側のトレースを行列のトレースへ移すこと**（$\operatorname{Tr}_A(\mu\theta^N)=\operatorname{Tr}(M_\mu M_\theta^{N})$）。
2. **$T$ と $M_\theta$ の側を結ぶこと**（$\chi$ が同じ 2 つの行列のトレース冪が一致すること）。

**本ファイルが書いたのは 1 である。**要るのは「$\mu$ 倍写像の行列を取る操作が環準同型であること」だけで、
$\mathbb{R}$ へも $\overline{\mathbb{Q}}$ へも出ない。**2 は残る。そう書く。**

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。使うのは有限自由加群のトレースと行列の積だけで、
係数環は任意の可換環である（本文が当てる先は $\mathbb{Z}$ と $\mathbb{Q}$。どちらも可算）。

## 書いたこと（3 段）

1. **$\operatorname{Tr}_A(z^N)=\operatorname{Tr}(M_z^{N})$**（`trace_pow_eq_trace_leftMulMatrix_pow`）。
   $z\mapsto M_z$ が $R$ 代数の準同型なので冪と交換し、
   `Algebra.trace_eq_matrix_trace` がトレースを移す。
2. **重み付きの形 $\operatorname{Tr}_A(\mu z^N)=\operatorname{Tr}(M_\mu M_z^{N})$**
   （`trace_mul_pow_eq_trace_leftMulMatrix`）。同じ理由で積とも交換する。
3. **本文の Gram 行列の成分がその形であること**（`weightedGram_apply_eq_matrix_trace`）。
   $G_{jk}=\operatorname{Tr}(M_\mu M_\theta^{\,j+k})$ と書ける。
   **本文の $G_{jk}=\operatorname{Tr}T^{j+k}$ と見比べると、残っているのは $T$ と $M_\mu M_\theta$ の関係だけになる。**

## 形式化しなかったもの

* **同じ特性多項式をもつ 2 つの行列のトレース冪が一致すること。**
  本文が「Newton の公式より」と引いている段である。上の実測のとおり、
  mathlib の Newton の関係は形式的な対称式の世界にあり、行列の特性多項式へ渡す橋が無い。
  自分で書くなら、分解体で根を取り出すか、
  逆特性多項式の対数微分（形式冪級数）を経由することになる。**どちらもまだ書いていない。**
* **成分ごとの分解（$\operatorname{Tr}_A(\mu\theta^N)=\sum_i a_i\operatorname{Tr}_{A_i}(\theta^N)$）。**
  cycle 42 step 1 が測った中国剰余の壁と同じものである（`WStarGramDiscriminant.lean` を見よ）。
-/
import Mathlib
import IntegrableLattice.EulerDualBasisCommRing

namespace IntegrableLattice
namespace WStarTracePowerBridge

open Polynomial Finset Module Matrix

section Bridge

variable {R : Type*} [CommRing R] {A : Type*} [CommRing A] [Algebra R A]
variable {m : ℕ} (b : Basis (Fin (m + 1)) R A)

/-- **代数のトレースの冪は、$z$ 倍写像の行列の冪のトレースである。**

$z\mapsto M_z$ が $R$ 代数の準同型なので冪と交換する。 -/
theorem trace_pow_eq_trace_leftMulMatrix_pow (z : A) (N : ℕ) :
    Algebra.trace R A (z ^ N) = Matrix.trace ((Algebra.leftMulMatrix b z) ^ N) := by
  classical
  rw [Algebra.trace_eq_matrix_trace b, map_pow]

/-- **重み付きの形**: $\operatorname{Tr}_A(\mu z^N)=\operatorname{Tr}(M_\mu M_z^{N})$。 -/
theorem trace_mul_pow_eq_trace_leftMulMatrix (μ z : A) (N : ℕ) :
    Algebra.trace R A (μ * z ^ N)
      = Matrix.trace (Algebra.leftMulMatrix b μ * (Algebra.leftMulMatrix b z) ^ N) := by
  classical
  rw [Algebra.trace_eq_matrix_trace b, map_mul, map_pow]

/-- **本文の Gram 行列の成分は $\operatorname{Tr}(M_\mu M_\theta^{\,j+k})$ である。**

本文は同じ成分を $\operatorname{Tr}T^{j+k}$ と書いている（命題 C′ の statement）。
**したがって残っているのは $T$ と $M_\mu M_\theta$ の関係だけである。** -/
theorem weightedGram_apply_eq_matrix_trace (θ μ : A) (j k : Fin (m + 1)) :
    EulerDualBasis.weightedGram (R := R) (m := m) θ μ j k
      = Matrix.trace (Algebra.leftMulMatrix b μ
          * (Algebra.leftMulMatrix b θ) ^ ((j : ℕ) + (k : ℕ))) :=
  trace_mul_pow_eq_trace_leftMulMatrix b μ θ ((j : ℕ) + (k : ℕ))

end Bridge

end WStarTracePowerBridge
end IntegrableLattice
