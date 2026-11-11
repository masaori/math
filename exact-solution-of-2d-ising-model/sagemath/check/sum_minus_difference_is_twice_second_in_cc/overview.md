# SageMath Check: sum_minus_difference_is_twice_second_in_cc

## 対象

**対象ラベル**: `sum_minus_difference_is_twice_second_in_cc`

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`
- ブロック: `calculation_formulae_claim_sum_minus_difference_is_twice_second_in_cc`（`a, b ∈ ℂ` で `(a+b) - (a-b) = 2_ℂ b`）
- 範囲: 主張と、証明の鎖の全行（17 行目が引く `one_plus_one_is_two_in_cc` の鎖は `sagemath/check/one_plus_one_is_two_in_cc/` が確かめる）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_chain.sage` | ℂ を `QQ[a0,a1,b0,b1]` の対で持ち、和・積・包含・`-z := (-1_C)z`・`z - w := z + (-w)` を本文の定義の式で書いた関数で、各行をその行の式の形のまま組み、隣り合う行が恒等的に等しいことを見る。差と符号反転を定義どおりに開く・閉じる行（1・2・3・5・9 行目）は組み方から自明に等しい。対照: 7 行目の `(-1_C)(-1_C)` を `-1_C`、13 行目の `a + (-a)` を `a` に替えると等号が切れる | **PASS** | 成り立つ |

## 計算の帰属と範囲

複素数の成分を `QQ` 上の多項式環の不定元に置いた。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ。浮動小数点と `RR` / `CC` への脱出はない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sum_minus_difference_is_twice_second_in_cc
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する（2026-11-11）。
