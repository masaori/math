# SageMath Check: complex_conjugate_of_real_inclusion

## 対象

**対象ラベル**: `complex_conjugate_of_real_inclusion` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_claim_complex_conjugate_of_real_inclusion`（実数の包含の複素共役は自分自身）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `conj(r_C) = conj((r,0)) = (r,-0) = (r,0) = r_C` の 4 行 | `check_chain.sage` | `r` を不定元に置いて隣り合う行が等しい。`r = 0, 1, -1, 1/2, -7/3` で主張を確かめ、Sage の `QQ(i)` の共役と比べた | **PASS** | 厳密等号 |

## 計算の帰属と範囲

浮動小数点はない。ℂ は実数の対で持った（`_shared/complex_as_real_pairs.sage`）。

具体の `r` で、本文の `conj(r_C)` を `QQ(i)` 係数へ送った値を Sage の `conjugate` と突き合わせた。

## 確かめられない行と理由

定義を開く行（`inclusion_rr_to_cc`・`def_complex_conjugate`）は同語反復である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh complex_conjugate_of_real_inclusion
```

実行ログは `sagemath/check/complex_conjugate_of_real_inclusion/logs/` に保存する。
