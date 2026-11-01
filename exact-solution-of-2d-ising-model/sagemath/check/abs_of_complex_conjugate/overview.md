# SageMath Check: abs_of_complex_conjugate

## 対象

**対象ラベル**: `abs_of_complex_conjugate` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_abs_of_complex_conjugate`（複素共役の絶対値）
- 範囲: 鎖の全 4 行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `|conj z| = |(x,−y)|`（`def_complex_conjugate`） | `check_abs_chain.sage` | 不定元で `cc_conj((x,y)) = (x,−y)`、具体の点で `AA` の値を比べる | **PASS** | 厳密等号 |
| `= √(x²+(−y)²)`（`abs_basic_properties` (1)） | 同上 | 根号の中を `QQ[x,y]` で、根号を取った値を `AA` の具体の点で比べる | **PASS** | 24 点で厳密等号 |
| `= √(x²+y²)`（ℝ で `(−y)² = y²`） | 同上 | 同上 | **PASS** | 同上 |
| `= |z|`（`abs_basic_properties` (1)）と主張 | 同上 | 両端を QQbar の `conjugate`・`abs` と比べた | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点はない。根号は実代数的数 `AA` の中で厳密に取る（`_shared/complex_as_real_pairs.sage` の `cc_abs_aa`）。
点は `0`、`3−4i` などの固定した 4 点と、乱数の種を固定した有理数の 20 点。

## 確かめられない行と理由

- `abs_basic_properties` (1) を当てはめる行は、検算での絶対値の組み方そのものが (1) なので同語反復である。独立な確認は QQbar の `abs` との比較が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh abs_of_complex_conjugate
```
