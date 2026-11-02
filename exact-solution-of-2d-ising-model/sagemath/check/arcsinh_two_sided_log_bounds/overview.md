# SageMath Check: arcsinh_two_sided_log_bounds

## 対象

**対象ラベル**: `arcsinh_two_sided_log_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_arcsinh_two_sided_log_bounds`（y > 0 なら log(2y) ≤ arcsinh(y) ≤ log(2y) + 1/(4y²)）
- 範囲: 下からの評価の二行と上からの評価の五行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 上からの評価の 3・4 行目（四則と分配則） | `check_proof_lines.sage` | QQ(y) の等号として厳密に | **PASS** | 成り立つ |
| log の引数の大小（2・下からの評価の 2 行目の前提） | `check_proof_lines.sage` | 7 点の y ∈ QQ_{>0} で AA で厳密に | **PASS** | 成り立つ |
| 1 行目（def_arcsinh）と log の値の各行・主張 | `check_proof_lines.sage` | 同じ 7 点で、本文の定義どおりの log(y + √(y²+1)) と Arb の asinh（別の経路）、各行の log をボールで | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | y = 10 で余りを 1/(8y²) に減らすと成り立たない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 四則と分配則の行は `QQ(y)` で、log の引数の大小は `AA` で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`・`ComplexBallField(256)`）**: log の値だけ（Arb の log）。値が QQ・AA に入らないためである。判定は差のボールの下端の符号（大小）と、差のボールが 0 を含み半径が 2^-200 未満であること（等号）で行い、許容誤差は置かない（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arcsinh_two_sided_log_bounds
```

実行ログは `logs/` に保存する。
