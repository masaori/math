# SageMath Check: 双曲線関数の添字つき略記の正値性

## 対象

**対象ラベル**: `indexed_hyperbolic_abbreviations_positive`

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: 正の `K_i,K_i^*` に対する `2K_i,2K_i^*>0`、`cosh(2K)>sinh(2K)>0`、定義置換後の `c_i>s_i>0`、`c_i^*>s_i^*>0`、および四つの略記の正値性

## チェック一覧

| ファイル | 検証内容 | 判定数 | ステータス |
|---|---|---:|---|
| `check_two_K_positive.sage` | `2K_i>0` | 5 | **PASS** |
| `check_two_K_star_positive.sage` | `2K_i^*>0` | 5 | **PASS** |
| `check_cosh_sinh_K_chain.sage` | `\cosh(2K_i)>\sinh(2K_i)>0` | 10 | **PASS** |
| `check_cosh_sinh_K_star_chain.sage` | `\cosh(2K_i^*)>\sinh(2K_i^*)>0` | 10 | **PASS** |
| `check_unstarred_definition_chain.sage` | 定義置換後の `c_i>s_i>0` | 10 | **PASS** |
| `check_starred_definition_chain.sage` | 定義置換後の `c_i^*>s_i^*>0` | 10 | **PASS** |
| `check_s_i_positive.sage` | `s_i>0` | 5 | **PASS** |
| `check_s_i_star_positive.sage` | `s_i^*>0` | 5 | **PASS** |
| `check_c_i_positive.sage` | `c_i>0` | 5 | **PASS** |
| `check_c_i_star_positive.sage` | `c_i^*>0` | 5 | **PASS** |

200 bit の実数区間演算を使い、区間の下端が厳密に正であることを判定する。許容誤差は用いない。これは代表値に対するプログラミングによる検証であり、全正実数についての一般証明は Lean の `indexedHyperbolicAbbreviations_pos` が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh indexed_hyperbolic_abbreviations_positive
```
