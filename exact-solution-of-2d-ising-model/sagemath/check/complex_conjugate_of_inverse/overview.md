# SageMath Check: complex_conjugate_of_inverse

## 対象

**対象ラベル**: `complex_conjugate_of_inverse` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_of_inverse`（逆元の複素共役は複素共役の逆元）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備の `\overline{w} = (x,-y)` と `\overline{w} ≠ 0` | `check_chain.sage` | `w = (x, y)` を `QQ(x, y)` に置き、`\overline{w}` の成分と、成分の平方和が `w` のものと同じ（`w ≠ 0` なら 0 でない）ことを見る | **PASS** | 厳密等号 |
| 準備の鎖 `\overline{w}\,\overline{w^{-1}} = \overline{ww^{-1}} = \overline{1_ℂ} = 1_ℂ` の 3 行 | `check_chain.sage` | 逆元を `multiplicative_group_of_cc` の `(a,b)^{-1} = (a/(a^2+b^2), -b/(a^2+b^2))` で組み、隣り合う行が等しい | **PASS** | 厳密等号 |
| 主鎖 `\overline{w^{-1}} = 1_ℂ\overline{w^{-1}} = ((\bar w)^{-1}\bar w)\overline{w^{-1}} = (\bar w)^{-1}(\bar w\,\overline{w^{-1}}) = (\bar w)^{-1}1_ℂ = (\bar w)^{-1}` の 5 行 | `check_chain.sage` | 同じ | **PASS** | 厳密等号 |
| 主張 | `check_chain.sage` | 具体の `w` 5 個で、本文の値を `QQ(i)` へ送り、Sage の共役・逆元と突き合わせる | **PASS** | 厳密等号 |

- 否定コントロール 1 件: 共役を取らない逆元 `w^{-1}` は `(\bar w)^{-1}` と一般には異なる。

## 計算の帰属と範囲

浮動小数点はない。ℂ は実数の対で持った（`_shared/complex_as_real_pairs.sage`）。成分は `QQ` 上の有理関数体 `QQ(x, y)` の元である。

## 確かめられない行と理由

準備の `\overline{w} ≠ 0` の背理法（`(x,-y) = (0,0)` から `y = 0`）は、成分の平方和の一致で代えて見ている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_of_inverse
```

実行ログは `sagemath/check/complex_conjugate_of_inverse/logs/` に保存する。
