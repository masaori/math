# 章 019「最大固有値の所在（偶セクターへの確定）」の Lean 形式化で見つかったこと

- 対象: `structured-latex/content/019_max_eigenvalue_sector.ts`（6 ブロック）
- 発見経緯: Lean 形式化（`lean/Ising2D/Part019/`、抽象版 `lean/Ising2D/Abstract/PermSector.lean`）
- 結論から言うと、**本文の主張に誤りは見つからなかった**。以下は
  (a) 形式化できなかった箇所とその理由、(b) 本文が置いている仮定が結論に対して過剰である箇所、
  (c) 章 011 の既知の穴が本章で埋まったこと、の 3 点である。

---

## (a) 形式化できなかった箇所: `c_equals_c_plus` の Step 2・Step 3

`c_equals_c_plus`（`sector_004_theorem_c_equals_c_plus`）は 3 段からなる。

| Step | 内容 | Lean |
| --- | --- | --- |
| 1 | `c(M) = max(c_+, c_-) = c_+(M)` | **無条件で形式化済み**（`Ising2D.c_equals_c_plus`） |
| 2 | `c_+(M) = Λ^{(1/2)}_M` を代入して `c(M) = Λ^{(1/2)}_M` | 仮定つき（`Ising2D.rayleighSup_eq_of_sectorRayleighSup_pos_eq`） |
| 3 | 上限が偶セクターの単位ベクトルで達成される | 仮定つき（`Ising2D.rayleighSup_attained_in_even_sector`） |

Step 2・Step 3 が引く `c_plus_equals_Lambda_half_integer` は**章 018**の定理である
（`structured-latex/content/018_even_sector_closing.ts` の 2061 行目で `labels` に定義）。
本リポジトリの Lean 側にはこれに対応する形式化が存在しない。一次情報:

```
$ grep -rn "cPlus\|c_plus\|Lambda_half" --include=*.lean lean/Ising2D/
（本タスクで追加した章 019 のファイル内のコメント以外にヒットは無い）
```

なお `Ising2D.LambdaM`（章 012、`lean/Ising2D/Part012/Theorem005_OnsagerFreeEnergy.lean`）は
`Λ^{(δ)}_M` の**表式そのもの**の定義であって、`c_+(M) = Λ^{(1/2)}_M` という等号ではない。

そのため Step 2 は「`c_+(M) = Λ` を仮定すれば `c(M) = Λ`」、
Step 3 は「`c_+(M)` を達成する偶セクターの単位ベクトル `x_0` があれば `x_0` は `c(M)` を達成する」
という条件つきの形にした。**章 019 に固有の内容（Step 1、および `c_minus_le_c_plus`）は
すべて無条件に証明されている。**

もう 1 つの仮定は `ε W = W ε`（実行列としての可換性）である。複素側では
`Ising2D.epsilon_commute_V1half` / `Ising2D.epsilon_commute_V2`（章 010）で証明済みだが、
複素の `V_1, V_2` と章 011 の実行列 `W` を結ぶ橋渡し（章 009・010 → 章 011）が未形式化なので、
章 011 と同様に仮定として受け取っている（`lean/docs/ch011-formalization.md` 参照）。

---

## (b) 本文が置いている仮定が結論に対して過剰な箇所（誤りではない）

### (b-1) `abs_vector_moves_to_even_sector` (3) に `W_{kl} > 0` は要らない

本文 (3) の証明は `W_has_positive_entries`（`W_{kl} > 0`）を引くが、実際に使っているのは

- `|x_k x_l W_{kl}| = |x_k||x_l| W_{kl}`（`W_{kl}` を絶対値の外へ出す）
- 有限個の実数についての三角不等式

の 2 つだけで、いずれも **`0 ≤ W_{kl}` で足りる**。Lean 側では非負版
`Ising2D.Abstract.abs_quad_le_quad_absVec`（仮定は `∀ k l, 0 ≤ W k l`）で証明し、
本文どおりの正値版 `Ising2D.quad_le_quad_absVec_epsilonR` はその系にしてある。

### (b-2) `epsilon_is_sign_flip_permutation` (2) の「不動点をもたない」は `c_- ≤ c_+` に効かない

本文は (2) で `π(k) ≠ k`（不動点をもたない対合）を示し、
それを (4)（`𝓕^{(-)}` が単位ベクトルを含む）に使っている。
しかし **不等式 `c_-(M) ≤ c_+(M)` の証明自体には不動点の有無は効いていない**。
Lean 側の `Ising2D.Abstract.sectorRayleighSup_neg_le_pos` は
「`ε` が対合 `π` の置換行列」「`W` が実対称半正定値で成分が非負」しか仮定しておらず、
`π` の不動点について何も仮定していない（`M` についても仮定していない）。

不動点をもたないことが効くのは「`𝓡_-` が空でない」＝ `c_-(M)` が上限として意味をもつ、
という部分だけである（本文 Step 1）。これは本文の議論の順序として正しいが、
「不等式の証明に (2) が必要」と読めてしまう書き方なので、区別を明示すると読みやすい。

### (b-3) `𝓡_+` が空でないことに不動点の有無は要らない

本文 Step 1 は `𝓡_+ ≠ ∅` を「`ε` が `(e_1 + e_{π(1)})/√2` を固定する」ことから出しているが、
このベクトルは `π(1) = 1` でも（`e_1` の 2 倍として）非零で `ε` 不変なので、
**不動点の有無に関係なく `𝓡_+ ≠ ∅` が言える**（`Ising2D.Abstract.sectorSet_pos_nonempty`）。

---

## (c) 章 011 の既知の穴（`002_ch011-sector-sup-nonempty-gap.md`）が本章で埋まった

`002_ch011-sector-sup-nonempty-gap.md` に記録したとおり、章 011 は `c_±(M)` を上限として
定義しながら「`𝓕^{(±)}` に単位ベクトルが存在すること」を述べていなかった。

章 019 の `epsilon_is_sign_flip_permutation` (4) が `𝓕^{(-)}` 側の単位ベクトルを
明示的に構成しており、この穴の半分が本文で埋まった。Lean 側では

- `Ising2D.sectorSet_neg_nonempty_epsilonR`（`M ≥ 1` が要る。本文は `M ≥ 2` を仮定）
- `Ising2D.sectorSet_pos_nonempty_epsilonR`（仮定不要）

の 2 本で両側とも埋めてある。章 011 本文を直すなら、この 2 つを引く形が自然である
（本文の修正は別セッションの担当なので、ここには記録だけ残す）。

---

## 参考: 形式化に使った道具

Perron–Frobenius の定理・スペクトル定理・行列の対角化可能性は一切使っていない
（本文の指示どおり、mathlib の Perron–Frobenius 系の補題へ迂回せず、成分ごとの不等式で書いた）。
使ったのは有限個の実数の和・積・絶対値と三角不等式、および実数の上限（`sSup`）だけである。
実数解析（極限・積分・連続性）は使っていないので、mathlib の探索も不要だった。
