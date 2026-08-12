# SageMath Check: セクターごとの生成多項式と、低温展開の自明セクター表示

## 対象

**対象ラベル**: `claim_low_temperature_trivial_sector_expression`

- 併せて検証: `def_sector_generating_polynomial`
- 範囲: 四つのセクターの生成多項式 $G^{a,b}_L\in\mathbb{Z}[x]$ を全辺部分集合の数え上げで作り、$D_L=G^{0,0}_L$ と $Z_L=2G^{0,0}_L$、および双対像が元の個数を保つこと（$|\delta_L(B)|=|B|$）を厳密検査する

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、$G^{a,b}_L$ を `ZZ[x]` で数え上げ、全配位からの $Z_L$・$D_L$ と突き合わせて $D_L=G^{0,0}_L$ と $Z_L=2G^{0,0}_L$ を厳密検査する | PASS | 全件一致 |

## 実行方法

```sh
sage sagemath/check/sector-generating-polynomial/check.sage
```

**2026-08-13 実行: すべて通過。**
