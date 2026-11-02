# SageMath Check: commutator_of_scalar_multiples

## 対象

**対象ラベル**: `commutator_of_scalar_multiples`

- ファイル: `structured-latex/content/005_exp_conjugation_proof.ts`
- ブロック: `exp_conjugation_proof_claim_commutator_of_scalar_multiples`（スカラー倍どうしの交換子 `[αX, βW] = (αβ)[X, W]`）
- 範囲: 証明の鎖の全 10 行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全 10 行（交換子の定義・スカラー倍を左右の因子の外へ出す・スカラー倍の結合律・ℂ の積の可換律・差への分配・交換子の定義） | `check_commutator_of_scalar_multiples.sage` | α・β と X・W の成分を `QQ(i)` 上の独立な不定元にし、各行を本文の積（`mat_mult`）・スカラー倍・差の成分の式で作って、隣り合う行が一致。最初の値を Sage の `[αX, βW]`、最後の値を Sage の `(αβ)(XW - WX)` とも比べる。対照: `[αX, βW] ≠ α[X, W]` | **PASS** | 行列の大きさ 1〜3 で厳密等号 |

## 計算の帰属と範囲

- 成分は `QQ(i)` 上の多項式環の不定元で、不定元での等号は全ての複素数の成分での等号を表す。浮動小数点は使わない。
- 範囲外: 大きさ 4 以上の行列（成分の式は大きさによらないが、検算は 1〜3 だけ）。
- この鎖はもと `nesting_of_commutator_of_H_and_check_Z` の証明の準備にあり、その検算 `check_bilinearity.sage` をここへ移した。

## 確かめられない行と理由

- ℂ の積の可換律の行 `(αβ)(XW) - (βα)(WX) = (αβ)(XW) - (αβ)(WX)` は、可換な多項式環の元として係数を作るので、作り方から必ず通る。
- 最初と最後の交換子の定義の行は、検算の交換子 `comm_body` が定義の式 `XW - WX` そのものなので、作り方から必ず通る。最初の値は Sage の `*`・`-` の交換子とも比べる。
- 中身を確かめているのは、スカラー倍を積の左右の因子の外へ出す行、スカラー倍の結合律の行、差への分配の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh commutator_of_scalar_multiples
```

実行ログは `logs/` に保存する。
