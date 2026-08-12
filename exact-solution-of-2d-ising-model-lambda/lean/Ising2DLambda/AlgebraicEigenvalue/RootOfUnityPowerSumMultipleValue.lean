/-
章「固有値の代数性」の「指数が根の次数の倍数のとき、冪の和は根の次数の与える代数的数である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張
`claim_root_of_unity_power_sum_multiple_value` に対応する。

  人手証明                                          このファイル
  準備 1（μ_n の有限性）                            `[Fintype (RootOfUnity n)]`（powerSum の仮定として受け取る）
  準備 2（|μ_n| = n と数え上げの全単射 e）          `hcard`（`rootOfUnityCardEq` を `Fintype.card` へ写す）と
                                                    `Fintype.equivFin`（数え上げの全単射の供給）
  第 1 の等号（S の定義）                            `powerSum` の定義そのもの（`rfl`）
  第 2 の等号（各項が 1）                            `rootOfUnityPowerOfMultiple` を各項へ（`Finset.sum_congr`）
  第 3 の等号（全単射 e による添字の取り替え）        `Fintype.sum_bijective` と `Fin.sum_univ_eq_sum_range`
  第 4 の等号（単位元の n 個の和は n）               `qbarUnitSumEqRational`

数え上げの全単射の存在は、人手証明が初等的事実として使っている箇所であり、
`Fintype.equivFin` から供給する（`IsAlgClosed.exists_root` を根の供給に使ったのと同じ扱い）。
定数の有限和をまとめた既製定理（`Finset.sum_const`・`Finset.card_nsmul` 等）へは委ねない。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSum
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerOfMultiple
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityCard
import Ising2DLambda.AlgebraicEigenvalue.QbarUnitSumEqRational

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 準備 2 の前半。μ_n の元の個数（`Fintype.card`）が n に等しい。
`rootOfUnityCardEq`（`Set.ncard` の言明）を `Fintype.card` へ写す。 -/
theorem rootOfUnityFintypeCard (n : ℕ) (hn : 1 ≤ n) [Fintype (RootOfUnity n)] :
    Fintype.card (RootOfUnity n) = n := by
  calc Fintype.card (RootOfUnity n)
      = Nat.card (RootOfUnity n) := Nat.card_eq_fintype_card.symm
    _ = (RootOfUnity n).ncard := Nat.card_coe_set_eq (RootOfUnity n)
    _ = n := rootOfUnityCardEq n hn

/-- 人手証明の本体。`n ≥ 1`・`n ∣ m` ならば `S_{n,m} = n`
（`claim_root_of_unity_power_sum_multiple_value`）。 -/
theorem powerSumMultipleValue {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)]
    {m : ℕ} (hdiv : n ∣ m) :
    powerSum n m = algebraMap ℚ Qbar (n : ℚ) := by
  -- 準備 2。|μ_n| = n。
  have hcard : Fintype.card (RootOfUnity n) = n := rootOfUnityFintypeCard n hn
  calc powerSum n m
      = ∑ z : RootOfUnity n, (z.1) ^ m := rfl
        -- 第 1 の等号。S の定義そのもの。
    _ = ∑ _z : RootOfUnity n, (1 : Qbar) :=
        Finset.sum_congr rfl
          (fun z _ => rootOfUnityPowerOfMultiple hn z.2 hdiv)
        -- 第 2 の等号。各項が 1（claim_root_of_unity_power_of_multiple）。
    _ = ∑ _i : Fin (Fintype.card (RootOfUnity n)), (1 : Qbar) :=
        Fintype.sum_bijective (Fintype.equivFin (RootOfUnity n))
          (Fintype.equivFin (RootOfUnity n)).bijective _ _ (fun _ => rfl)
        -- 第 3 の等号（前半）。数え上げの全単射 e による添字の取り替え。
    _ = ∑ _i ∈ Finset.range (Fintype.card (RootOfUnity n)), (1 : Qbar) :=
        Fin.sum_univ_eq_sum_range (fun _ : ℕ => (1 : Qbar))
          (Fintype.card (RootOfUnity n))
        -- 第 3 の等号（後半）。番号の集合 {i | i < |μ_n|} にわたる和として書く。
    _ = ∑ _i ∈ Finset.range n, (1 : Qbar) := by rw [hcard]
        -- 準備 2 の |μ_n| = n を当てる。
    _ = algebraMap ℚ Qbar (n : ℚ) := qbarUnitSumEqRational n
        -- 第 4 の等号。単位元の n 個の有限和は n。

end Ising2DLambda.AlgebraicEigenvalue
