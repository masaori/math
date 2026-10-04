# SageMath Check: 双対辺写像の全単射性

## 対象

**対象ラベル**: `claim_dual_edge_map_bijective`

- 併せて検証: `def_dual_edge_map`
- ファイル: `structured-latex/content/main-text.ts`（ブロック `fisher_zero_claim_dual_edge_map_bijective`）
- 範囲: 双対辺写像と明示した逆写像の二つの往復律。横向き辺・縦向き辺それぞれの三行の等式鎖を、隣接する式の対ごとに検算する。

以下では $i,j,\bar1\in\mathbb Z/L\mathbb Z$ とし、座標内の加法・減法はすべてこの剰余類環で行う。
$L=1,\dots,5$ の各向き55辺、合計110辺を対象にする。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_horizontal_inverse_after_dual_definition.sage` | $\eta_L(\delta_L(n_{\mathrm h}(i,j)))=\eta_L(n_{\mathrm v}(i,j+\bar1))$ | PASS | 55辺で一致 |
| `check_horizontal_inverse_after_dual_inverse.sage` | $\eta_L(n_{\mathrm v}(i,j+\bar1))=n_{\mathrm h}(i,(j+\bar1)-\bar1)$ | PASS | 55辺で一致 |
| `check_horizontal_inverse_after_dual_cancel.sage` | $n_{\mathrm h}(i,(j+\bar1)-\bar1)=n_{\mathrm h}(i,j)$ | PASS | 55辺で一致 |
| `check_vertical_inverse_after_dual_definition.sage` | $\eta_L(\delta_L(n_{\mathrm v}(i,j)))=\eta_L(n_{\mathrm h}(i+\bar1,j))$ | PASS | 55辺で一致 |
| `check_vertical_inverse_after_dual_inverse.sage` | $\eta_L(n_{\mathrm h}(i+\bar1,j))=n_{\mathrm v}((i+\bar1)-\bar1,j)$ | PASS | 55辺で一致 |
| `check_vertical_inverse_after_dual_cancel.sage` | $n_{\mathrm v}((i+\bar1)-\bar1,j)=n_{\mathrm v}(i,j)$ | PASS | 55辺で一致 |
| `check_horizontal_dual_after_inverse_definition.sage` | $\delta_L(\eta_L(n_{\mathrm h}(i,j)))=\delta_L(n_{\mathrm v}(i-\bar1,j))$ | PASS | 55辺で一致 |
| `check_horizontal_dual_after_inverse_dual.sage` | $\delta_L(n_{\mathrm v}(i-\bar1,j))=n_{\mathrm h}((i-\bar1)+\bar1,j)$ | PASS | 55辺で一致 |
| `check_horizontal_dual_after_inverse_cancel.sage` | $n_{\mathrm h}((i-\bar1)+\bar1,j)=n_{\mathrm h}(i,j)$ | PASS | 55辺で一致 |
| `check_vertical_dual_after_inverse_definition.sage` | $\delta_L(\eta_L(n_{\mathrm v}(i,j)))=\delta_L(n_{\mathrm h}(i,j-\bar1))$ | PASS | 55辺で一致 |
| `check_vertical_dual_after_inverse_dual.sage` | $\delta_L(n_{\mathrm h}(i,j-\bar1))=n_{\mathrm v}(i,(j-\bar1)+\bar1)$ | PASS | 55辺で一致 |
| `check_vertical_dual_after_inverse_cancel.sage` | $n_{\mathrm v}(i,(j-\bar1)+\bar1)=n_{\mathrm v}(i,j)$ | PASS | 55辺で一致 |
| `check.sage` | 全辺について、像と逆像が辺全体を過不足なく動き、両方向の合成が恒等写像になることを検査 | PASS | 全110辺の二つの往復律と全単射性が一致 |

## 備考

行別検算では座標を `Zmod(L)` の元とし、代表を取る `lift()` を通して本文と同じ整数の番号付け写像へ渡す。
双対辺写像と逆写像は辺番号から向きと座標を復元して計算する。
既存の `check.sage` は整数の剰余による実装を保ち、行別検算とは別に全体の往復律を確認する。
浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。有限サイズの検算であり、任意の $L$ の証明は本文と Lean が担う。

## 実行方法

プロジェクト直下で実行する。

```sh
for dual_check_file in sagemath/check/dual-edge-map-bijective/check*.sage; do
  micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage -c \
    "__file__ = '$dual_check_file'; load(__file__)" || exit
done
```

**2026-08-12 実行: すべて通過。**

**2026-10-04 実行（SageMath 10.9）: 行別12本（各55辺、計660等式）と既存の `check.sage` がすべて `RESULT: PASS`。**
