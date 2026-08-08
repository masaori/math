/-
主張「反復の回数は足し算になる」「もとへ戻る反復の回数は最小周期の倍数である」
「最小周期は格子の一辺を割り切る」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.RowShiftPeriod`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ向きの帰納法・同じ除法の使い方）。

  主張                                  使っている性質
  iterLeft_add                          **何も要求しない。** 型 ι と写像 f : ι → ι が
                                        1 つあればよく、全単射性も有限性も相等の判定も
                                        要らない。すなわち行配位であることも、
                                        シフトが巡回であることも使っていない。
  iterLeft_mul                          上に加えて「その点が e 回で戻ること」だけ。
  iterLeft_eq_self_iff                  上に加えて e が最小であること（`Nat.find` の性質）と、
                                        ℕ の除法。値の型にも添字の型にも構造を要求しない。
  minimalPeriod_dvd_of_iterLeft_eq_self 上と同じ。

削れなかった仮定。最小周期が定まるためには「1 回以上の反復で戻る回数が存在すること」が要る
（人手証明が `claim_row_config_shift_period` から `L ∈ K(τ)` を出しているのにあたる）。
これは点ごとの仮定であって、写像 f が全体として周期を持つことは要求していない。
すなわち **f が全単射である必要も、ι が有限である必要も無い**。

mathlib の `Function.minimalPeriod` / `Function.IsPeriodicPt` は引いていない。
引くと「K(τ) の最小元として定める」という人手証明の定め方が既製の定義へ置き換わる。
使ったのは `Nat.find`（自然数の整列性）と ℕ の除法の基本性質だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、回数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftMatrixOrder

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι : Type*}

/-- 人手証明の主張「反復の回数は足し算になる」。

型にも写像にも何も要求しない。 -/
theorem iterLeft_add (f : ι → ι) (a b : ℕ) (i : ι) :
    iterLeft f (a + b) i = iterLeft f a (iterLeft f b i) := by
  induction a with
  | zero =>
    -- 0 + b = b、S^[0] = id
    rw [Nat.zero_add]
    rfl
  | succ a ih =>
    -- (a+1) + b = (a+b) + 1、S^[k+1] = S ∘ S^[k]
    rw [Nat.succ_add]
    show f (iterLeft f (a + b) i) = f (iterLeft f a (iterLeft f b i))
    rw [ih]

/-- 人手証明の最小周期 `e(τ)`。`K(τ)` の最小元として定める（`Nat.find` が自然数の整列性）。

仮定 `h` が人手証明の「`K(τ)` は空でない」にあたる。 -/
noncomputable def minimalPeriod (f : ι → ι) (i : ι)
    (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) : ℕ :=
  open Classical in Nat.find h

/-- 最小周期は 1 以上である。 -/
theorem minimalPeriod_pos (f : ι → ι) (i : ι) (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) :
    1 ≤ minimalPeriod f i h := by
  classical
  exact (Nat.find_spec h).1

/-- 最小周期だけ反復するともとへ戻る。 -/
theorem iterLeft_minimalPeriod (f : ι → ι) (i : ι) (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) :
    iterLeft f (minimalPeriod f i h) i = i := by
  classical
  exact (Nat.find_spec h).2

/-- 最小周期より小さい 1 以上の回数では、もとへ戻らない。 -/
theorem not_iterLeft_of_lt_minimalPeriod (f : ι → ι) (i : ι)
    (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) {k : ℕ} (hk1 : 1 ≤ k)
    (hk : k < minimalPeriod f i h) : iterLeft f k i ≠ i := by
  classical
  intro hcontra
  exact Nat.find_min h hk ⟨hk1, hcontra⟩

/-- 人手証明の「割り切れるならばもとへ戻る」の側（`q` についての帰納法）。 -/
theorem iterLeft_mul (f : ι → ι) (i : ι) (e : ℕ) (he : iterLeft f e i = i) (q : ℕ) :
    iterLeft f (e * q) i = i := by
  induction q with
  | zero => rw [Nat.mul_zero]; rfl
  | succ q ih =>
    -- e(q+1) = eq + e、S^[eq+e](τ) = S^[eq](S^[e](τ)) = S^[eq](τ) = τ
    rw [Nat.mul_succ, iterLeft_add, he, ih]

/-- 人手証明の主張「もとへ戻る反復の回数は最小周期の倍数である」。 -/
theorem iterLeft_eq_self_iff (f : ι → ι) (i : ι) (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i)
    (k : ℕ) : iterLeft f k i = i ↔ minimalPeriod f i h ∣ k := by
  classical
  constructor
  · intro hk
    -- k = e q + r（0 ≤ r < e）と書き、S^[r](τ) = τ を出して最小性に反させる
    set e := minimalPeriod f i h with he
    have hepos : 0 < e := minimalPeriod_pos f i h
    have hsplit : k % e + e * (k / e) = k := Nat.mod_add_div k e
    have hr : iterLeft f (k % e) i = i := by
      calc iterLeft f (k % e) i
          = iterLeft f (k % e) (iterLeft f (e * (k / e)) i) := by
            rw [iterLeft_mul f i e (iterLeft_minimalPeriod f i h) (k / e)]
        _ = iterLeft f (k % e + e * (k / e)) i := (iterLeft_add f (k % e) (e * (k / e)) i).symm
        _ = iterLeft f k i := by rw [hsplit]
        _ = i := hk
    rcases Nat.eq_zero_or_pos (k % e) with hzero | hpos
    · exact Nat.dvd_of_mod_eq_zero hzero
    · exact absurd hr (not_iterLeft_of_lt_minimalPeriod f i h hpos (Nat.mod_lt k hepos))
  · rintro ⟨q, rfl⟩
    exact iterLeft_mul f i _ (iterLeft_minimalPeriod f i h) q

/-- 人手証明の主張「最小周期は格子の一辺を割り切る」。

要るのは「`n` 回の反復でもとへ戻ること」だけで、`n` が格子の一辺であることも、
`f` の位数が `n` であることも使っていない。 -/
theorem minimalPeriod_dvd_of_iterLeft_eq_self (f : ι → ι) (i : ι)
    (h : ∃ k, 1 ≤ k ∧ iterLeft f k i = i) {n : ℕ} (hn : iterLeft f n i = i) :
    minimalPeriod f i h ∣ n :=
  (iterLeft_eq_self_iff f i h n).mp hn

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
