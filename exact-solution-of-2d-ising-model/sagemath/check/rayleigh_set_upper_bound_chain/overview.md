# SageMath Check: rayleigh_set_upper_bound_chain

## 対象

**対象ラベル**: `def_rayleigh_sup` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_006_definition_rayleigh_sup`（𝓡 は上に有界（|x_k| ≤ 1 のもとで x^⊤Wx ≤ Σ_iΣ_j|W_ij|））
- 範囲: 項ごとの 6 行、各 i の 2 行、外側の 4 行（x^⊤Wx ≤ |x^⊤Wx| から ΣΣ|W_ij| まで）。|x_i| ≤ 1 を出す前の段の鎖は含めない

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 範囲に書いた各行と主張 | `check_proof_lines.sage` | QQ 成分の d 次正方行列（d = 1〜6）と、Σx_k^2 = 1 の QQ の単位ベクトル（単位円の有理点を重ねて作る）の組 60 個で、各行の等号・不等号を厳密に | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ と AA（実代数的数）だけで計算した。浮動小数点は使わない。
- 範囲外: 選んだ以外の点。点での検算は証明ではなく、式変形の書き間違い・符号の誤りの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh rayleigh_set_upper_bound_chain
```

実行ログは `logs/` に保存する。
