# SageMath Check: arcsinh_argument_two_sided_bounds

## 対象

**対象ラベル**: `arcsinh_argument_two_sided_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_arcsinh_argument_two_sided_bounds`（y > 0 なら 2y ≤ y + √(y²+1) ≤ 2y + 1/(2y)）
- 範囲: 準備の鎖と、下からの評価・上からの評価の三行ずつ

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の鎖と、二つの評価の 1・2 行目 | `check_proof_lines.sage` | 関数体 QQ(y)[s]/(s²-y²-1) の等号として厳密に | **PASS** | 成り立つ |
| 二つの評価の 3 行目と主張 | `check_proof_lines.sage` | 7 点の y ∈ QQ_{>0} で s = √(y²+1) を AA で作り、厳密に比べる | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | y = -1 では上からの評価が成り立たない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は関数体 `QQ(y)[s]/(s²-y²-1)` で、大小の行と主張は `AA` で確かめた。
- **`ℝ` への脱出**: なし。

範囲外のもの:

- 選んだ以外の点。微分の公式・(R3)・(R4)・円周率の数値の評価そのもの（本文が外部から持ち込む事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arcsinh_argument_two_sided_bounds
```

実行ログは `logs/` に保存する。
