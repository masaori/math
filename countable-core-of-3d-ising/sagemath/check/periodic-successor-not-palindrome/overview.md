# SageMath Check: 奇数軌道では多重度は回文でない

## 対象

**対象ラベル**: `claim_periodic_successor_not_palindrome`

- ファイル: `structured-latex/content/periodic-structural-core.ts`
- ブロック: `periodic_structural_core_claim_odd_orbit_not_palindrome`
- 範囲: 定数配位による下端、奇数軌道の有限積による全辺破れの否定、端点多重度の不一致
- 帰属: 有限集合と `ZZ` のみ。浮動小数点と非可算への脱出は使わない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_configuration.sage` | 定数配位の破れ数が 0 で、下端多重度が正である | PASS | 軌道長 1・3・5、二方向で確認 |
| `check_odd_orbit_product.sage` | $(-1)^L=-1$ を `ZZ` で確認し、全軌道辺が破れる配位が 0 個であることを全配位で確認（前件だけで assert すると空虚に通るため） | PASS | 軌道長 1・3・5 の全配位で確認 |
| `check_orbit_product_square.sage` | 同じ有限積が頂点値の有限積の二乗で 1 になる | PASS | 軌道長 1・3・5 の全配位で確認 |
| `check_endpoint_multiplicities.sage` | 奇数軌道で $\Omega_E(0)\ne\Omega_E(\#E)$ になる | PASS | 軌道長 1・3・5、二方向で確認 |

**2026-08-15 実行: すべて通過。**

## 実行方法

```sh
sage sagemath/check/periodic-successor-not-palindrome/check.sage
```
