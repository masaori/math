# SageMath Check: arctan_zero

## 対象

**対象ラベル**: `arctan_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_arctan_zero`（arctan 0 = 0）
- 範囲: 主張 `arctan 0 = 0` と、証明の鎖 8 行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 `arctan 0 = arcsin(0/√(1+0^2))`（`def_arctan` の `x → 0`） | `check_proof_lines.sage` | Sage の `arctan(0)` と `def_arctan` の右辺を記号計算で比べる | **PASS** | 厳密 |
| 2〜6 行目（`square_of_real_number_is_product`・`real_zero_times_is_zero`・`set_and_algebra_notation` の加法の単位元 `1 + 0 = 1`・`sqrt_of_real_one_is_one`・`real_zero_divided_is_zero`（`1 ≠ 0` は体の公理））| 同上 | 置き換えた部分式の等号 5 個と、隣り合う行の arcsin の引数の等号 5 個（QQ、√ は AA）。6 行目の条件 `1 ≠ 0` も確かめる | **PASS** | 厳密（等号 10 個） |
| 4 行目の ℝ の加法の単位元を引く根拠（`set_and_algebra_notation`）: `1 + 0 = 1`（`x + 0 = x` の `x → 1`） | `check_unit_rows_cite_set_and_algebra_notation.sage` | 行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈（根号の中）の穴にそれを入れたものと `QQ` で等しいことを確かめる。式を正規化するので、形の左右と向きは区別できず、それはレビューの目視で確かめた。対照（`1 + 1 ≠ 1`） | **PASS** | 厳密（1 行） |
| 7 行目 `arcsin(0) = arcsin(sin 0)`（`sine_zero`） | 同上 | `_shared/polar_trigonometry_exact.sage` の `cos_sin` で作った角度 0 の sin が 0（AA） | **PASS** | 厳密 |
| 8 行目 `arcsin(sin 0) = 0`（`def_sin` を `0 ∈ [−π/2, π/2]`（`zero_in_closed_interval_from_minus_half_pi_to_half_pi`）で） | 同上 | `0 ∈ [−π/2, π/2]` と、記号計算の `arcsin(sin 0) = 0` | **PASS** | 厳密 |
| 否定コントロール | 同上 | 分子を 0 から 1・−1・1/2 に取り違えると arcsin の引数が 0 でなくなる。`sin 0` を `cos 0` に取り違えると 7 行目が崩れる | **PASS** | 4 件 |

## 計算の帰属と範囲

arcsin の引数は `QQ` と `AA` で厳密に判定する。1 行目と 8 行目は arcsin・arctan の値を Sage の記号計算（`SR`）で比べる。
浮動小数点は使わない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arctan_zero
```

実行ログは `sagemath/check/arctan_zero/logs/` に保存する（2026-11-15、SageMath 10.9）。
