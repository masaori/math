# SageMath Check: sine_bound_constant_numerical_bounds

## 対象

**対象ラベル**: `sine_bound_constant_numerical_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sine_bound_constant_numerical_bounds`（0.5887 ≤ c₀ ≤ 0.5888）
- 範囲: 二つの鎖の各四行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の三つの不等式（24 で割る・-1 を掛ける・1 を足す）と 1・2 行目 | `check_proof_lines.sage` | π のボールで | **PASS** | 成り立つ |
| 3〜5 行目（有理数の四則と大小） | `check_proof_lines.sage` | QQ で厳密に | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | π のボールでも | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 有理数の四則と大小（3〜5 行目）は `QQ` で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: π（または π²）を含む量の大小だけ。π が `QQ`・`AA` に入らないためである。Arb の `pi()` は π を厳密に含む区間で、判定は差のボールの下端の符号で行い、許容誤差は置かない。

範囲外のもの:

- なし。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_bound_constant_numerical_bounds
```

実行ログは `logs/` に保存する。
