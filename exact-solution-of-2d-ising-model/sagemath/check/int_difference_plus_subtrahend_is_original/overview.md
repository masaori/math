# SageMath Check: int_difference_plus_subtrahend_is_original

## 対象

**対象ラベル**: `int_difference_plus_subtrahend_is_original` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_difference_plus_subtrahend_is_original`（`x, y ∈ ℤ` について `(x −_ℤ y) +_ℤ y = x`）
- 範囲: 主張と、証明の 4 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 4 行の鎖（`(x − y) + y = (x + (−y)) + y = x + ((−y) + y) = x + 0 = x`） | `check_proof_lines.sage` | 差を `def_int_difference` の `x + (−y)` で書いた関数で作り、`ZZ[x, y]` で各段の前後が等しいことを確かめる | **PASS** | 厳密（等号 4 個） |
| 各行の根拠の形（`def_int_difference`、加法の結合律、加法の逆元 `(−y) + y = 0`、和の単位元 `y + 0 = y`） | 同上 | 行に書いた代入で形の両辺を作って等しいことを確かめる。多項式環は式を正規化するので、行ごとにどの規則を当てたかの区別はレビューの目視で確かめる | **PASS** | 厳密（4 つ） |
| 主張 `(x − y) + y = x` | 同上 | 整数 `−40..40` の全ての組で、全ての行と主張が `x` に一致し、`def_int_difference` の差が組み込みの差と一致すること | **PASS** | 6561 件 |
| 否定コントロール | 同上 | 差を `x + y` と取り違えると左辺は `x + 2y`。加法の逆元の段で `(−y) + y` を `y + y` と取り違えると 3 行目と一致しない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 多項式環 `ZZ[x, y]` と `ZZ` だけで計算した。浮動小数点は使わない。
- 範囲外: 検算は式変形の書き間違いの裏取りであり、証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_difference_plus_subtrahend_is_original
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
