# SageMath Check: 117_conjugation_is_ring_homomorphism

## 対象

**対象ラベル**: `conjugation_is_ring_homomorphism` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`

- 範囲: T_B(A)=BAB^{-1} の乗法性・単位性・合成則、および <mat_conj> の線型性

B は exp で作って正則性を保証している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_ring_hom.sage` | 乗法性・単位性・線型性・合成則 T_A∘T_B = T_{AB} | 240 | 1.859e-12 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<mat_conj>（T_B が線型）はこの check に含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 117
```

実行ログは `sagemath/check/117_conjugation_is_ring_homomorphism/logs/` に保存してある（この表の数値はそのログから取った）。
