#include "appcore.h"
#include <QDebug>

AppCore::AppCore(QObject *parent)
    : QObject{parent}
{}

void AppCore::debugPrint()
{
    qDebug() << "hello world";
}
