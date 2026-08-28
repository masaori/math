# SageMath Check: 第二の極限量候補ではどの閾値の先にも交差冪等式の破れがある

## 対象

**対象ラベル**: `claim_second_limit_candidate_has_tail_cross_power_failure`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_second_limit_candidate_has_tail_cross_power_failure`）
- 範囲: 結論が述べる証拠の存在を、小さい閾値について実際に有理数の不等式として得ること、および仮定 $q\ne1$ が落とせないこと

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_witness_exists_beyond_small_thresholds.sage` | 閾値 $K=0,1$ について、有理点 1 以外の標本で $Z_L(q)^{\#V_M}\ne Z_M(q)^{\#V_L}$ となる二箱の組が実際に見つかること | PASS | `RESULT: PASS` |
| `check_at_one_no_witness_exists.sage` | 有理点 1 では同じ二箱の組で交差冪等式が成り立ち、破れの証拠が得られないこと（仮定 $q\ne1$ の必要性） | PASS | `RESULT: PASS` |

## 備考

- 任意の閾値にわたる全称は無限個の箱についての主張なので有限検査の対象外であり、本文と Lean の検証対象である。有限検査で確かめられるのは、結論の証拠が小さい閾値で実在すること（主張が空虚でないこと）と、仮定の必要性である。
- 全配位を列挙できる箱は一辺 1 と 2 だけなので、証拠に使える二箱の組は $(L,M)=(1,2)$ に限られ、扱える閾値は $K\le1$ である（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。
- 破れの判定は根を作らず交差冪の有理数等式で行い、`QQ` の中で閉じる。
- `ZZ` と `QQ` の厳密計算だけを使い、浮動小数点および新たな非可算への脱出は使わない。

実行日: 2026-08-29。2 ファイルとも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/second-limit-candidate-has-tail-cross-power-failure/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done
```
