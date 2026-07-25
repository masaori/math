/-
# 基本となる型の定義

人手証明（`parts/**/*.typ`）で `Mat(2, CC)^(times.o M)` と書かれている対象を Lean 上で
どう表現するかを固定する。

対応する人手証明:
- `parts/004_転送行列/000_definition_転送行列の記号の定義.typ` (`<def_transfer_matrix_symbols>`)
- `parts/004_転送行列/004_definition_EndFとMat2Cテンソル積Mの同型.typ`
-/
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.RingTheory.PiTensorProduct

open scoped TensorProduct

namespace Ising2D

/-- スピン配置の型。`M` サイトの各々が 2 準位をとる。

`Fin M → Fin 2` は `Fintype` かつ `DecidableEq` なので、そのまま `Matrix` の添字型として
使える。人手証明で多重添字 `I = (i_1, …, i_M) ∈ {1,2}^M` と書かれているものがこれ。
（`parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` の `I, J`） -/
abbrev Conf (M : ℕ) : Type := Fin M → Fin 2

/-- **本プロジェクトで採用する `Mat(2, ℂ)^{⊗M}` の表現**。

スピン配置 `Conf M = Fin M → Fin 2` で添字づけられた行列環。
`Matrix (Conf M) (Conf M) ℂ` は
- 環・ℂ-代数（`Matrix.instRing`, `Matrix.instAlgebra`）
- 行列指数関数 `NormedSpace.exp`（`Mathlib.Analysis.Normed.Algebra.MatrixExponential`）
- 中心の決定 `Matrix.center_eq_scalar_image`
- 行列単位 `Matrix.single I J 1` とその積公式 `Matrix.single_mul_single_same`
をすべて mathlib から直接受け取れる。

`AbstractTensorPow M` との ℂ-代数同型は
`Ising2D.tensorPowAlgEquiv`（`Ising2D/Representation.lean`）で証明する。 -/
abbrev TensorPow (M : ℕ) : Type := Matrix (Conf M) (Conf M) ℂ

/-- 比較対象としての抽象テンソル冪表現 `⨂[ℂ] (i : Fin M), Mat(2, ℂ)`。

人手証明の記法に見た目は最も近いが、
- ノルム環の構造が入らない（`NormedSpace.exp` が使えない）
- 行列式・跡・固有値など行列固有の API が一切使えない
ため、本プロジェクトの主対象（`V_1 = exp(...)`, `V_2 = exp(...)`）を扱えない。 -/
abbrev AbstractTensorPow (M : ℕ) : Type := ⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ

end Ising2D
