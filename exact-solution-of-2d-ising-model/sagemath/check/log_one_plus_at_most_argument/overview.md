# SageMath Check: log_one_plus_at_most_argument

## 対象

**対象ラベル**: `log_one_plus_at_most_argument` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_log_one_plus_at_most_argument`（x ≥ 0 なら log(1+x) ≤ x）
- 範囲: 準備の鎖、被積分関数の鎖、積分の鎖、最後の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の鎖 log(1+0) = log 1 = log(exp 0) = 0 | `check_proof_lines.sage` | 本文の exp の部分和 S_N([0]) が QQ で厳密に 1、Arb の log 1 が厳密に 0 | **PASS** | 成り立つ |
| H' の鎖の三行と積分の鎖の 2・4 行目（(R4) の当てはめ） | `check_proof_lines.sage` | SR の記号微分・記号積分（x > 0 を仮定） | **PASS** | 成り立つ |
| 被積分関数の鎖と 3 行目の各点の符号 | `check_proof_lines.sage` | QQ(v) の等号と、[0, x] の 11 点で QQ の大小 | **PASS** | 成り立つ |
| 積分の鎖の両端・主張 | `check_proof_lines.sage` | 7 点の x ∈ QQ_{>0} で log をボールで囲み、x - log(1+x) > 0 と log(1+x) ≤ x が確定 | **PASS** | 成り立つ |
| 最後の鎖の等号 | `check_proof_lines.sage` | QQ[x, ℓ] の等号 | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | x = 1 で log(1+x) ≤ x/2 は成り立たない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: exp 0 = 1 は本文の部分和で `QQ` で、被積分関数の鎖は `QQ(v)` で、符号は `QQ` の大小で、最後の鎖の等号は `QQ[x, ℓ]`（ℓ は log(1+x) の不定元）で確かめた。H' の鎖と (R4) の当てはめの行は `SR` の記号微分・記号積分で確かめた（SR の log の微分は本文が持ち込む微分の公式と同じ公式）。
- **`ℝ` への脱出（`RealBallField(512)`・`ComplexBallField(256)`）**: 主張と積分の鎖の両端の log の値だけ（Arb の log）。log の値が QQ に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh log_one_plus_at_most_argument
```

実行ログは `logs/` に保存する。
