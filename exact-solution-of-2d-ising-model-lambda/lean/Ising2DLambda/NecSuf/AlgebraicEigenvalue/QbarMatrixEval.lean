/-
主張「成分ごとの評価は行列の積を保つ」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.QbarMatrixEval`）と同じである
（積の定義で開く → 写像が有限和を保つ → 各項で写像が積を保つ → 積の定義へ戻す）。

  使っている性質                なぜ削れないか
  `Fintype ι`                   有限和 `∑ j, …` を取るのに要る。
  `AddCommMonoid S` `Mul S`     行列の積 `matProduct` を書くために要る（和の順序に依らない
  `AddCommMonoid T` `Mul T`     有限和と、成分どうしの積）。積の結合則も単位元も使わない。
  `hsum`                        第 3 段。写像が有限和を保つこと。
  `hmul`                        第 4 段。写像が積を保つこと。

`hsum` と `hmul` を型クラス（環準同型 `S →+* T`）ではなく素の仮定として置いたのは、
この段が要求するのが**この 2 本の等式だけ**であることを見せるためである。
実際、写像が零元を保つことも、加法を 2 項ごとに保つことも、単位元を保つことも使っていない
（`hsum` は有限和についての等式であって、そこから 2 項の加法の保存は出さない）。

削れたもの: 積の可換性・積の結合則・単位元・零元でない元の逆元・分配則・
体であること・値が代数的数であること（`Qbar`）・係数が整数であること・
写像が多項式への代入であること・添字が行配位であること・添字の相等が判定できること。
すなわちこの段は「有限和と積を保つ写像を成分ごとに施すこと」だけであり、
対象が行列であること以外の性質を一つも使っていない。

行列の積は `Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrixOrder` の `matProduct` を使う
（同じ定義を 2 つ置かない）。

住処: ここに ℝ / ℂ は現れない（値は一般の加法可換モノイド + 乗法をもつ型の元）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrixOrder

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 必要十分版の本体。人手証明の鎖の第 2 段から第 6 段までを、
成分ごとの等式として書いたものである（第 1 段は評価の定義そのもの）。 -/
theorem matEval_product_necSuf
    {ι : Type*} [Fintype ι] {S T : Type*}
    [AddCommMonoid S] [Mul S] [AddCommMonoid T] [Mul T]
    (f : S → T)
    (hsum : ∀ g : ι → S, f (∑ j : ι, g j) = ∑ j : ι, f (g j))
    (hmul : ∀ a b : S, f (a * b) = f a * f b)
    (A B : ι → ι → S) (i k : ι) :
    f (matProduct A B i k)
      = matProduct (fun i j => f (A i j)) (fun j k => f (B j k)) i k :=
  calc f (matProduct A B i k)
      = f (∑ j : ι, A i j * B j k) := rfl
        -- 第 2 段。行列の積の定義。
    _ = ∑ j : ι, f (A i j * B j k) := hsum _
        -- 第 3 段。写像が有限和を保つこと。
    _ = ∑ j : ι, f (A i j) * f (B j k) := sum_congr rfl fun _ _ => hmul _ _
        -- 第 4 段。写像が積を保つこと。
    _ = matProduct (fun i j => f (A i j)) (fun j k => f (B j k)) i k := rfl
        -- 第 5・6 段。評価の定義へ戻し、行列の積の定義へまとめること。

/-- 単位行列を、この段が要求する最小の構造だけで書いたもの。
`ShiftMatrixOrder` の `identityMat` は section variable により `AddCommMonoid S` と `Mul S` を
要求するが、**この段は和も積も一度も使わない**（対角で `1`、対角の外で `0` と読むだけである）。
必要十分版の目的は「使っていない構造を仮定に残さないこと」なので、ここでは
`Zero` と `One` と添字の相等の判定だけを要求する形で置く。
定義が分岐しないことは下の `identityMatMin_eq_identityMat` で押さえる。 -/
def identityMatMin {ι : Type*} [DecidableEq ι] {S : Type*} [Zero S] [One S] : ι → ι → S :=
  fun i j => if i = j then (1 : S) else (0 : S)

/-- 余計な構造があるときは `identityMat` と一致する（同じ定義を 2 つ置いたことにならない）。 -/
lemma identityMatMin_eq_identityMat {ι : Type*} [Fintype ι] [DecidableEq ι]
    {S : Type*} [AddCommMonoid S] [Mul S] [One S] :
    (identityMatMin : ι → ι → S) = (identityMat : ι → ι → S) := rfl

/-- 主張「成分ごとの評価は単位行列を単位行列へ写す」の必要十分版。
証明手順は具体版（`qbarMatrixEval_identity`）と同じである
（成分ごとに、添字が等しいかで場合を分け、各場合で 4 段の鎖をたどる）。

  使っている性質                なぜ削れないか
  `DecidableEq ι`               単位行列の定義の場合分けに要る。
  `Zero S` `One S`              `ℤ[x]` 側の単位行列を書くのに要る。
  `Zero T` `One T`              値の側の単位行列を書くのに要る。
  `hone`                        添字が等しい場合の第 3 段。写像が単位元を単位元へ送ること。
  `hzero`                       添字が異なる場合の第 3 段。写像が零元を零元へ送ること。

削れたもの: 有限性（`Fintype ι`）・加法・乗法・それらの法則・写像が和や積を保つこと・
体であること・値が代数的数であること。すなわちこの段は「単位元を単位元へ、零元を零元へ送る
写像を成分ごとに施すこと」だけである。 -/
theorem matEval_identity_necSuf
    {ι : Type*} [DecidableEq ι] {S T : Type*} [Zero S] [One S] [Zero T] [One T]
    (f : S → T) (hone : f (1 : S) = (1 : T)) (hzero : f (0 : S) = (0 : T)) (i j : ι) :
    f (identityMatMin i j) = (identityMatMin : ι → ι → T) i j := by
  by_cases h : i = j
  · calc f ((identityMatMin : ι → ι → S) i j)
        = f (1 : S) := by rw [identityMatMin, if_pos h]
          -- 第 2 段。添字が等しいときの単位行列の成分。
      _ = (1 : T) := hone
          -- 第 3 段。写像が単位元を単位元へ送ること。
      _ = (identityMatMin : ι → ι → T) i j := by rw [identityMatMin, if_pos h]
          -- 第 4 段。値の側の単位行列の成分へ戻すこと。
  · calc f ((identityMatMin : ι → ι → S) i j)
        = f (0 : S) := by rw [identityMatMin, if_neg h]
          -- 第 2 段。添字が異なるときの単位行列の成分。
      _ = (0 : T) := hzero
          -- 第 3 段。写像が零元を零元へ送ること。
      _ = (identityMatMin : ι → ι → T) i j := by rw [identityMatMin, if_neg h]
          -- 第 4 段。値の側の単位行列の成分へ戻すこと。

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
