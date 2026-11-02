# SageMath Check: pi_squared_numerical_bounds

## 対象

**対象ラベル**: `pi_squared_numerical_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_pi_squared_numerical_bounds`（9.8696 ≤ π² ≤ 9.8697）
- 範囲: 前提と二つの鎖の各五行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 前提 0 < 3.141592 ≤ π ≤ 3.141593（外部から持ち込む円周率の数値） | `check_proof_lines.sage` | π のボールで | **PASS** | 成り立つ |
| 2・3 行目（π を含む積の大小） | `check_proof_lines.sage` | π のボールで | **PASS** | 成り立つ |
| 4・5 行目（有理数の積と大小） | `check_proof_lines.sage` | QQ で厳密に | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | π のボールでも | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | 3.14159 ≤ π だけでは 9.8696 に届かない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 有理数の積と大小（4・5 行目）は `QQ` で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: π（または π²）を含む量の大小だけ。π が `QQ`・`AA` に入らないためである。Arb の `pi()` は π を厳密に含む区間で、判定は差のボールの下端の符号で行い、許容誤差は置かない。

範囲外のもの:

- なし。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh pi_squared_numerical_bounds
```

実行ログは `logs/` に保存する。
