# 章 018「偶セクターの完結（Onsager の厳密解）」の Lean 形式化で判明したこと

対象: `structured-latex/content/018_even_sector_closing.ts`（12 ブロック）
形式化: `lean/Ising2D/Part018/`（具体版）、`lean/Ising2D/Abstract/ParityFermion.lean`（抽象版）

**`structured-latex/` は一切編集していない。** 以下はすべて記録のみである。

## 1. 人手証明に見つけた誤り

**なし。** 章 018 の各主張について、Lean 側で反例・不整合は見つからなかった。
形式化できた範囲（下記 2 の「形式化済み」）では、人手証明の論証手順をそのまま追える。

## 2. 人手証明の「穴」ではなく、Lean 側の未整備による未形式化

章 018 は章 014–017（半整数運動量のフェルミオン `ψ̌`、個数演算子 `ň`、同時固有射影 `Q̌_ε`、
`V^{(+)}` の固有値）の上に立つが、**それらは本リポジトリの Lean 側に存在しない**。

一次情報:

```
$ cd exact-solution-of-2d-ising-model/lean
$ grep -rn "checkPsi\|checkNum\|checkQ" --include=*.lean Ising2D/
（章 013 の checkZ / checkY 以外にヒットなし）
$ ls Ising2D/
Abstract Basic.lean Part000 Part002 Part004 Part006 Part007 Part008 Part009
Part010 Part011 Part012 Part013 Part015 Part018 Part019 Representation.lean
（Part014 / Part016 / Part017 が無い）
```

そこで**章 014–017 から受け取る入力だけを束ねた構造**を 2 つ置き、章 018 の主張は
すべてそこからの帰結として証明した。

| 構造 | 受け取る内容 | 出典の章 |
| --- | --- | --- |
| `Ising2D.CheckFermi`（`Part018/Setup.lean`） | `ψ̌_μ^†, ψ̌_μ` の正準反交換関係、`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` | 016 |
| `Ising2D.VPlusData`（`Part018/Claim003_...`） | `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`、`Λ̌_ε = C exp(∑γ(θ̃_μ)(ε_μ-1/2))`、`C > 0`、`γ(θ̃_μ) > 0` | 015・017 |
| `Ising2D.EvenSectorBridge`（`Part018/Theorem009_...`） | 章 011 の実行列 `W` と章 017 の複素行列 `V^{(+)}` の橋渡し（`W P^{(+)} = V^{(+)} P^{(+)}`） | 011・017 |

**これらは人手証明の穴ではない。**いずれも原文が明示的に引用している既証明の主張であり、
Lean 側で該当章がまだ形式化されていないだけである。

## 3. `tr(εV^{(+)}) > 0` を仮定として残した理由（一次情報）

人手証明 `max_eigenvector_in_even_sector` (1) は `trace_of_epsilon_V_plus`
（`closing_006_theorem_trace_of_epsilon_V_plus`）を使う。この定理は

```
tr(εV^{(+)}) = (2e^{-K_2} cosh K_1)^M + (2e^{K_2} sinh K_1)^M > 0
```

を**直接計算**で出すもので、その計算は

- `closing_004_claim_H1_plus_in_sigma_z_form`（`iH_1^{(+)} = D_0 + εG`、`σ^z` 表示）
- `closing_005_definition_open_chain_spin_energy`・`closing_005_claim_open_chain_partition_sum`・`closing_005_claim_open_chain_endpoint_product_sum`・`closing_005_claim_open_chain_spin_sums_positive`（1次元開鎖のエネルギー定義、二つのスピン和と正値性
  `∑_s e^{KE(s)} = 2(2\cosh K)^{M-1}` ほか）

を要する。原文自身が「**この計算には `Ž, Y̌, ψ̌` も半整数運動量も現れない**」と述べている
とおり、これは章 018 の他の主張とは独立の、配置基底での組合せ論的計算である。

本セッションでは、章 018 の主鎖（`ε` の固有値 → `η_{(1,…,1)} = +1` → `c_+(M) = Λ̌_max`
→ Onsager）を通すことを優先し、この枝は形式化していない。したがって
`Ising2D.VPlusData.eta_univ_eq_one` 以降の定理は `0 < (tr(εV^{(+)})).re` を仮定として受け取る。

**この仮定は人手証明で証明済みであり、循環参照はない**（`trace_of_epsilon_V_plus` は
`epsilon_eigenvalue_on_check_Q` にも `max_eigenvector_in_even_sector` にも依存しない）。

## 4. 人手証明より強い結果になった箇所（相違点の記録）

`closing_010_theorem_onsager_exact_solution` の人手証明は Step 2・Step 3 で
`Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M` という**粗い挟み撃ち**を採る。原文 `conversion.notes` に
よれば、これは `c_-(M)` の値に依存しないためである。

一方、**章 019 の `Ising2D.c_minus_le_c_plus` は `c_-(M) ≤ c_+(M)` を無条件に与える**ので、
`c_-(M)` の値を知らなくても `c(M) = c_+(M)` が言える（`Ising2D.c_equals_c_plus`）。
そこで Lean 側（`Part018/Theorem010_OnsagerExactSolution.lean` の
`EvenSectorBridge.rayleighSup_eq_LambdaM`）は挟み撃ちを経由せず、直接

```
c(M) = c_+(M) = Λ̌_max = Λ^{(1/2)}_M
```

を出している。**得られる結論は人手証明と同じ**（挟み撃ち版で必要だった `log 2 / M → 0` が
不要になるだけ）なので、本文を直す必要はないが、より短い経路が存在することは記録しておく。

## 5. 抽象版で判明した「人手証明が過剰に仮定していること」

`lean/docs/ch018-formalization.md` の 2 章に詳述した。要点のみ:

1. **符号の反転則 `η_{ε[μ→1]} = -η_ε`（人手証明 (2)）に `im Q̌_ε` の 1 次元性は要らない。**
   人手証明は (1)(2) の両方で 1 次元性を引くが、1 次元性が本当に必要なのは
   (1)（`η_ε` の**存在**）だけである。(2) の Step 1・Step 2 は環の計算だけで閉じる
   （`Ising2D.Abstract.projOn_insert_mul_cre` / `Abstract.cre_mul_projOn_ne_zero`）。
2. **`ε` が `ň_μ`・`Q̌_ε` と可換であること（人手証明 (4)）に効いているのは、
   `ε` が生成・消滅演算子の両方と反交換することだけ**である。台は任意の環でよく、
   行列であることも複素数であることもテンソル冪であることも効いていない。
3. **`tr(εV^{(+)})` の積への分解（人手証明 Step 2）に効いているのは
   `Finset.prod_add` と `sinh x = (e^x - e^{-x})/2` だけ**である。`γ` が `arccosh` で
   書けることも `V^{(+)}` が転送行列であることも効いていない。

いずれも「本文が間違っている」のではなく「本文の仮定が必要以上に強い」だけなので、
指示どおり本文は変更していない。
