# SageMath Check: 有限二部後続系の多重度の回文性

**対象ラベル**: `claim_structural_palindrome`

本文（帰無モデル: 箱から整数の算術を落とす）の証明の各段を、複数の小さい
有限二部後続系の全数列挙で一段ずつ確かめる。すべて `ZZ` と有限集合の列挙による
厳密計算であり、浮動小数点は使わない。点は座標ではなく単なるラベルとして持ち、
検証コードでも整数の加法・順序・座標和を系の定義に使わない
（箱の例の構成だけは座標から系を作るが、作った後は他の系と同じ扱いである）。

| 確かめた段 | 本文のラベル | 方法 |
| --- | --- | --- |
| 二色塗り分けの仮定（全辺で両端の色が異なる） | `def_bipartite_successor_system` | 各系の全辺 |
| 色 1 反転が対合（$T(T\sigma)=\sigma$） | `def_structural_color_flip` | 各系の全配位 |
| 各辺の破れの反転（$(T\sigma)(\partial_0e)\ne(T\sigma)(\partial_1e)\Leftrightarrow\sigma(\partial_0e)=\sigma(\partial_1e)$） | `claim_structural_palindrome` の証明第二段 | 全配位 × 全辺 |
| 破れ辺集合の補集合化（$D(T\sigma)=E\setminus D(\sigma)$。集合として） | 同 第三段 | 全配位 |
| 破れ数の補数（$b(T\sigma)=\#E-b(\sigma)$） | 同 第四段 | 全配位 |
| 多重度の回文性（$\Omega_E(m)=\Omega_E(\#E-m)$） | `claim_structural_palindrome` | 全配位の多重度集計 |

系の選び方（主張のどの場合を覆うか）:

- **道**（点 4、succ は方向 1 だけ、単射、交互の二色）: 一方向だけの最小の非自明例。
- **整数の箱 $L=2$**（点 8、辺 12、三方向の succ、座標和の偶奇の二色）:
  もとの箱が有限二部後続系の例になっていることの確認。二色塗り分けの成立検査が
  本文の「辺の両端の座標和の偶奇は異なる」に相当する。配位 $2^8$ の全数列挙で、
  多重度の総和 256・辺数 12 が自由境界の検証（`free-boundary-palindrome`）と一致する。
- **星**（葉 3 つが同じ中心へ写る、succ が**単射でない**系）: 証明の最終段の観察
  「$\operatorname{succ}_i$ の単射性は回文性そのものには不要」を、単射でない系でも
  証明の四段と回文性がすべて成り立つことで確かめる。

```sh
sage sagemath/check/bipartite-successor-palindrome/check.sage
```

**2026-08-14 実行: すべて通過。**
