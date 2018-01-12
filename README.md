# dotfiles eli omat conffitiedostot

The documentation is in finnish as the only intended user is myself.

## Lyhyt kuvaus

Tällä repolla on kaksi tavoitetta:

1. Tallentaa kaikki minun konfiguraatiotiedostot siten että pääsen niihin käsiksi
   kaikkialta
1. Ylläpitää asennusskriptiä jolla minun konfiguraation saa koneelle hirvittävän
   helposti, joko puhtaalta pöydältä, tai päivittäen vain niitä mitä tarvitaan.

Pidättäydyn oletuksessa on että alla oleva distro on jossain määrin Ubuntu.
Kirjoitushetkellä läppärissäni ja pöytäkoneessa Xubuntu 17.10, työkoneessa
Ubuntu 16.04. No, nämä konfiguraatiot koskevat myös Window Manageria, joten ei
ole suurta väliä onko alkuun Ubuntu, Xubuntu tai mikä muu. Oleellista on että
oletuksena että toimitaan Debian pakettien kanssa, `apt` työkalulla, ja alkuun on
jo tiettyjä repoja omissa lähdelistoissa.

Olen tutustunut nyt erilaisiin lähestymistapohin käsitellä
konfiguraatiotiedostoja. Tällä hetkellä olen päätynyt siihen, että tiedosto
pysyvät oman repon sisällä, ja oikeissa sijainneissa käytetään symbolisia
linkkejä ohjaamaan näihin tiedostoihin. Tätä varten käytetään `GNU Stow`
ohjelmaa. Vastaavanlainen lähestymistapa on
käytössä [tällä henkilöllä](https://github.com/mohabaks/dotfiles), josta olen
ottanut
mallia.
[Vaihtoehtoinen lähestymistapa](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) olisi
ollut tehdä oma komento, joka ikään kuin toimisi kuin että repo eläisi
kotihakemiston alla.

Tällä hetkellä en ole vielä perehtynyt, miten hoitaisin henkilökohtaisten
tiedostojen synkronoinnin, joita en halua julkisesti jakaa. Jos jollakulla on
tähän hyviä ideoita, otan mielelläni ehdotuksia vastaan.

Tämän hetken asetelma on seuraavanlainen:
* Bar `polybar`
* Program launcher `rofi`
* Shell `zsh`
* Shell settings `antigen`
* Text editor `emacs/spacemacs`
* Terminal emulator `gnome-terminal`
* Window manager `i3`
* Font for spacemacs `Source Code Pro`
* Pycharm
* Clion


## Asennus

Kirjoita myöhemmin

## Kuinka käyttää GNU Stowia

Laita kaikki tiedostot oman puunsa mukaisesti kotihakemistoon. Suorita repon juuressa
`stow -v -t ~ dotfiles`

Poista käytöstä
`stow -v -D -t ~ dotfiles`
