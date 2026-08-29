# Kac--Ward 行列式の定数項

## 対象

**対象ラベル**: `claim_kac_ward_determinant_constant_term_one`

四つの遷移行列から `K^{a,b}(x)=I-xM^{a,b}` と `D_L^{a,b}(x)=det K^{a,b}(x)` を構成する。

## 検査内容

- `L=1,2` と四つのスピン構造のすべてについて、`QQbar[x]` 成分の Kac--Ward 行列を構成する。
- `x=0` で単位行列になることを確認する。
- 行列式を厳密に計算し、定数項が `1` であることを確認する。

## 実行結果

2026-08-29: PASS。`QQbar[x]` の厳密計算だけを用い、浮動小数点は使っていない。

```bash
sage sagemath/check/kac-ward-determinant-constant-term/check.sage
```
