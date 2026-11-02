# SageMath Check: cosine_at_most_one

## 対象

**対象ラベル**: `cosine_at_most_one` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosine_at_most_one`（v ∈ [-π/2, π/2] なら cos v ≤ 1）
- 範囲: 準備・c² の鎖・背理法の鎖と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 c ≥ 0 と c² の鎖の三行 | `check_proof_lines.sage` | v = qπ（q = -1/2..1/2 の 25 点）で AA で厳密に | **PASS** | 成り立つ |
| 背理法の鎖（c·c > 1·c > 1·1 = 1） | `check_proof_lines.sage` | QQ[c] の差の恒等式と c > 1 の具体の有理数で | **PASS** | 成り立つ |
| 主張 | `check_proof_lines.sage` | 同じ 25 点で AA | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: sin・cos の値は、角度を π の有理数倍に限り、1 の冪根の虚部と、本文の定義 cos θ := √(1 - (sin θ)²) から `AA` で作る（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。等号の行は `QQ` 上の多項式環・`AA` で確かめた。c² の鎖の 1 行目は c をその定義の式で作っているので、独立の検算にはならない（定義の展開の行）。

範囲外のもの:

- 選んだ以外の v。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosine_at_most_one
```

実行ログは `logs/` に保存する。
