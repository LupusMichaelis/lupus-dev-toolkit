md()
{
    mkdir $1
    cd $_
}

mdnow()
{
    md $(date +%Y%m%d-%H%M)
}

mdtoday()
{
    md $(date +%Y%m%d)
}
